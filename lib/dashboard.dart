import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Welcome User",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            _drawerItem(Icons.person_add, "Register", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
            }),
            _drawerItem(Icons.event, "Add Event", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventScreen()));
            }),
            _drawerItem(Icons.help, "Help", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
            }),
            _drawerItem(Icons.contact_mail, "Contact Us", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
            }),
          ],
        ),
      ),
      body: Center(
        child: Text("Welcome to MeetUp ", style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown),
      title: Text(title),
      onTap: onTap,
    );
  }
}

// Screens
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(child: Text("Register Page")),
    );
  }
}

class AddEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Event")),
      body: Center(child: Text("Add Event Page")),
    );
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help")),
      body: Center(child: Text("Help Page")),
    );
  }
}

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Center(child: Text("Contact Us Page")),
    );
  }
}
