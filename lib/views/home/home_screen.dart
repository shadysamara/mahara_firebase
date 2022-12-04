import 'package:flutter/material.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
