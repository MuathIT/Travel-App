


import 'package:flutter/material.dart';
import 'package:travel_app/core/colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.brown[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.brown
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.brown[300]
          )
        ),
        cursorColor: Colors.brown[400],
        style: TextStyle(
          color: ColorsManager.darkBrown
        ),
      ),
    );
  }
}