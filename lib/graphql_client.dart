import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink('http://localhost:5000/graphql'); // Replace with your GraphQL endpoint

final GraphQLClient client = GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
);