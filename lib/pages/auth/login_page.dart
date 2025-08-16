

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controllers/auth/auth_controller.dart';
import 'package:travel_app/pages/auth/auth_page.dart';
import 'package:travel_app/pages/auth/register_page.dart';
import 'package:travel_app/pages/auth/widgets/auth_button.dart';
import 'package:travel_app/pages/auth/widgets/auth_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      height: 425,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // greet the user.
          Text(
            "Hello friend! You've been missed",
            style: GoogleFonts.lato(
              color: Colors.brown,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),

          // email text field.
          AuthTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Type your email..',
          ),
          const SizedBox(height: 25),

          // password text field.
          AuthTextField(
            controller: _pwdController,
            labelText: 'Password',
            hintText: 'Type your password..',
            obscureText: true,
          ),
          const SizedBox(height: 25),

          // login button.
          GestureDetector(
            onTap: () {
              // try to login the user.
              context.read<AuthCubit>().login(
                _emailController.text.trim(), 
                _pwdController.text.trim()
              );
            },
            child: const AuthButton(text: 'Log in'),
          ),
          const SizedBox(height: 25),

          // don't have an account? button.
          TextButton(
            onPressed: (){
              // navigate to register page.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => RegisterPage())
              );
            },
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.lato(
                  color: Colors.brown,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: "Don't have an account? "
                  ),
                  TextSpan(
                    text: "Register",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold
                    )
                  )
                ]
              )
            ),
          )
        ],
      )
    );
  }
}