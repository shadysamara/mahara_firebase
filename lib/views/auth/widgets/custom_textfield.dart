import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  TextEditingController controller;
  String label;
  CustomTextfield(this.controller, this.label);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin:EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
