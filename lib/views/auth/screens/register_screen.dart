import 'package:flutter/material.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:mahara_fb/views/auth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              CustomTextfield(provider.registerfnameCOntroller, 'first name'),
              CustomTextfield(provider.registerlnameCOntroller, 'last name'),
              CustomTextfield(provider.registerPhoneCOntroller, 'phone number'),
              
              CustomTextfield(provider.registerEmailCOntroller, 'Email'),
              CustomTextfield(provider.registerPasswordCOntroller, 'Password'),
              ElevatedButton(
                  onPressed: () {
                    provider.register();
                  },
                  child: Text('Register'))
            ],
          );
        },
      ),
    );
  }
}
