import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bottom_bar/bottom_bar.dart';
import 'package:travel_app/controllers/auth/auth_controller.dart';

class AuthPage extends StatelessWidget {
  final double? height;
  final Widget child;
  const AuthPage({super.key, this.height = 650, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.only(top: 80, left: 15),
          child: FloatingActionButton.small(
            elevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            backgroundColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            foregroundColor: Colors.brown,
            onPressed: () {
              // pop to splash page.
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading){
            const Center(child: CircularProgressIndicator());
          }
          else if (state is AuthSuccess){
            // navigate to home page.
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BottomBar()),
              (_) => false
            );
          }
          else if (state is AuthFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.failureMessage),
                duration: Duration(milliseconds: 900),
              )
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background1.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: height,
                width: double.infinity,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white70,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
