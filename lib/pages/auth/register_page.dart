import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controllers/auth/auth_controller.dart';
import 'package:travel_app/pages/auth/auth_page.dart';
import 'package:travel_app/pages/auth/login_page.dart';
import 'package:travel_app/pages/auth/widgets/auth_button.dart';
import 'package:travel_app/pages/auth/widgets/auth_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text controllers.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  // this method will confirm the passwords are same.
  bool confirmPasswords (){
    return _pwdController.text.trim() == _confirmPwdController.text.trim();
  }



  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // greet the user.
          Text(
            "Hello there! Let's travel together",
            style: GoogleFonts.lato(
              color: Colors.brown,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),

          // name text field.
          AuthTextField(
            controller: _nameController,
            labelText: 'Name',
            hintText: 'Type your name..',
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

          // confirm password text field.
          AuthTextField(
            controller: _confirmPwdController,
            labelText: 'Confirm Password',
            obscureText: true,
          ),
          const SizedBox(height: 25),

          // register button.
          GestureDetector(
            onTap: () {
              // check if passwords are same.
              if (confirmPasswords()){
                // try to register the user.
                context.read<AuthCubit>().register(
                  _nameController.text.trim().toUpperCase(),
                  _emailController.text.trim(),
                  _pwdController.text.trim(),
                );
              }
            },
            child: const AuthButton(text: 'Register'),
          ),
          const SizedBox(height: 25),

          // already have account? button.
          TextButton(
            onPressed: () {
              // navigate to login page.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.lato(color: Colors.brown, fontSize: 18),
                children: [
                  TextSpan(text: "Already have account? "),
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
