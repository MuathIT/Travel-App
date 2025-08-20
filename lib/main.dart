import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/controllers/auth/auth_controller.dart';
import 'package:travel_app/controllers/auth/search/search_controllers.dart';
import 'package:travel_app/core/data/shared_preference.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/pages/home/home_page.dart';
import 'package:travel_app/pages/splash/splash_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: const TravelApp(),
    );
  }
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharedPreferenceHelper().getString('uEmail') == null 
      ? const SplashPage()
      : HomePage()
    );
  }
}
