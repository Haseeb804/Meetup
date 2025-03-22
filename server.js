const express = require('express');
const { ApolloServer, gql } = require('apollo-server-express');
const neo4j = require('neo4j-driver');
const bcrypt = require('bcryptjs');
const cors = require('cors');

const app = express();
const port = 5000;

// Enable CORS for Flutter app
app.use(cors());
app.use(express.json());

// Connect to Neo4j Aura
const driver = neo4j.driver(
  "neo4j+s://dcee8aec.databases.neo4j.io",
  neo4j.auth.basic("neo4j", "elXAqUzyBuYI2d6AcJ1-854Z7RCMQPfQ-ftJTd4TTlI")
);

// Define GraphQL schema
const typeDefs = gql`
  type User {
    name: String!
    email: String!
  }

  type Query {
    hello: String
    test: String
  }

  type Mutation {
    signup(name: String!, email: String!, password: String!): String
    login(email: String!, password: String!): User
  }
`;

// Define resolvers
const resolvers = {
  Query: {
    hello: () => "Hello",
    test: async () => {
      const session = driver.session();
      try {
        const result = await session.run('MATCH (n) RETURN count(n) AS count');
        return `Count: ${result.records[0].get('count')}`;
      } catch (error) {
        console.error('Error querying Neo4j:', error);
        throw new Error('Failed to query Neo4j');
      } finally {
        session.close();
      }
    },
  },
  Mutation: {
    signup: async (_, { name, email, password }) => {
      const session = driver.session();
      try {
        console.log("Signup request received:", { name, email });

        // Validate input
        if (!name || !email || !password) {
          throw new Error("Name, email, and password are required");
        }

        // Check if user already exists
        const existingUser = await session.run(
          "MATCH (u:User {email: $email}) RETURN u",
          { email }
        );

        if (existingUser.records.length > 0) {
          console.log("User already exists:", email);
          throw new Error("User already exists");
        }

        // Hash password before saving
        const hashedPassword = await bcrypt.hash(password, 10);
        console.log("Password hashed successfully");

        // Create user node in Neo4j
        await session.run(
          "CREATE (u:User {name: $name, email: $email, password: $password})",
          { name, email, password: hashedPassword }
        );

        console.log("User registered successfully:", email);
        return "User registered successfully";
      } catch (error) {
        console.error("Error during signup:", error);
        throw new Error("Failed to register user: " + error.message);
      } finally {
        await session.close();
      }
    },
    login: async (_, { email, password }) => {
      const session = driver.session();
      try {
        console.log("Login request received:", { email });

        // Validate input
        if (!email || !password) {
          throw new Error("Email and password are required");
        }

        // Find user by email
        const result = await session.run(
          "MATCH (u:User {email: $email}) RETURN u.password AS hashedPassword, u.name AS name",
          { email }
        );

        if (result.records.length === 0) {
          console.log("User not found:", email);
          throw new Error("Invalid email or password");
        }

        // Extract stored hashed password and name
        const hashedPassword = result.records[0].get("hashedPassword");
        const name = result.records[0].get("name");

        // Compare entered password with stored hash
        const isMatch = await bcrypt.compare(password, hashedPassword);

        if (!isMatch) {
          console.log("Invalid password for user:", email);
          throw new Error("Invalid email or password");
        }

        console.log("Login successful for user:", email);
        return { name, email };
      } catch (error) {
        console.error("Error during login:", error);
        throw new Error("Failed to login: " + error.message);
      } finally {
        await session.close();
      }
    },
  },
};

// Create Apollo Server
const server = new ApolloServer({ typeDefs, resolvers });

// Start the server
async function startServer() {
  await server.start(); // Ensure the server is started before applying middleware
  server.applyMiddleware({ app });

  app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
    console.log(`GraphQL endpoint: http://localhost:${port}${server.graphqlPath}`);
  });
}

startServer().catch((error) => {
  console.error('Failed to start server:', error);
});