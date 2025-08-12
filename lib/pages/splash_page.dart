

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/core/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Center(
            child: Column(
              children: [
                // app phrase.
                Text(
                  "Navigate\nthe world",
                  style: GoogleFonts.radioCanada(
                    color: ColorsManager.darkBrown,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // let the trip planner guide you.
                Text(
                  'Let the trip planner guide you',
                  style: GoogleFonts.lato(color: Colors.brown[600], fontSize: 18),
                ),

                Spacer(),
                // form container.
                Container(
                  height: 275,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // create new account button.
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorsManager.darkBrown,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Create new account',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: ColorsManager.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // i already have an account button.
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'I already have an account',
                          style: GoogleFonts.lato(
                            color: ColorsManager.darkBrown,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),

                      // divider line.
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),

                      // sign up with.
                      Text(
                        'Sign up with',
                        style: TextStyle(
                          color: Colors.grey[600]
                        ),
                      ),

                      // apple, google and facebook buttons.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // apple.
                          GestureDetector(child: logo(BuildContext, Icon(Icons.apple, size: 30))),

                          // google.
                          GestureDetector(child: logo(BuildContext, Image.asset('assets/logos/google_logo.png'))),

                          // facebook.
                          GestureDetector(child: logo(BuildContext, Icon(Icons.facebook, color: Colors.blue, size: 30))),
                        ],  
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// function for logos shape.
Widget logo (BuildContext, Widget child) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(style: BorderStyle.solid, color: Colors.grey.shade400)
    ),
    child: child
  );
}