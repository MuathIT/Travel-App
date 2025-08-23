import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bottom_bar/bottom_bar.dart';
import 'package:travel_app/controllers/auth/auth_controller.dart';
import 'package:travel_app/controllers/favorite/favorite_controller.dart';
import 'package:travel_app/controllers/favorites/favorites_controller.dart';
import 'package:travel_app/controllers/search/search_controllers.dart';
import 'package:travel_app/controllers/home/home_controller.dart';
import 'package:travel_app/core/data/shared_preference.dart';
import 'package:travel_app/firebase_options.dart';
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
          create: (context) => HomeCubit()..loadHomeData(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit()..getFavTrips(),
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
      : BottomBar()
    );
  }
}
