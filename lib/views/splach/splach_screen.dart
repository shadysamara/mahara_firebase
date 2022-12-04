import 'package:flutter/material.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Consumer<AuthProvider>(
      builder: (context,provider,x) {
        return Scaffold(body: Center(child: Text('Splach'),),);
      }
    );
  }
}
