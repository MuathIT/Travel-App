


import 'package:flutter/material.dart';
import 'package:travel_app/core/colors.dart';

class TripDetailsPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  const TripDetailsPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
      ),
      body: Column()
    );
  }
}