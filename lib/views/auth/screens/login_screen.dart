import 'package:flutter/material.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:mahara_fb/views/auth/screens/register_screen.dart';
import 'package:mahara_fb/views/auth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              CustomTextfield(provider.loginEmailCOntroller, 'Email'),
              CustomTextfield(provider.loginPasswordCOntroller, 'Password'),
              ElevatedButton(
                  onPressed: () {
                    provider.login();
                  },
                  child: Text('Login')),
              ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateAndReplaceScreen(RegisterScreen());
                  },
                  child: Text('Create new Account'))
            ],
          );
        },
      ),
    );
  }
}
