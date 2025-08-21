
// ---------- Home States ----------
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeSuccess extends HomeState{
  final Map<String, dynamic> randomTrip; // for new for you trip.
  final List< Map<String, dynamic> > popularTrips; // for popular trips.
  HomeSuccess(this.randomTrip ,this.popularTrips);
}

class HomeFailure extends HomeState{
  final String failureMessage;
  HomeFailure(this.failureMessage);
}

// ---------- Home Cubit ----------
class HomeCubit extends Cubit<HomeState> {
  HomeCubit () : super (HomeInitial());

  final Dio dio = Dio();

  // this method will load the home data.
  Future<void> loadHomeData () async{
    emit(HomeLoading());

    try {
      // list of the popular trips titles.
      final popularCities = [
        'Bangkok', 
        'London', 
        'Paris', 
        'Dubai', 
        'Barcelona', 
        'New York City', 
        'Istanbul', 
        'Tokyo', 
        'Cape Town', 
        'Melbourne', 
        'Vienna', 
        'Milan',
        'Rome',
        'Amsterdam',
      ];

      // get a random trip from the above trips.
      final randomTrip = popularCities[Random().nextInt(popularCities.length)];
      
      popularCities.remove(randomTrip); // remove the given random trip so it doesn't show up again in the popular trips section.
      // here will store the given random trip details into the new trip.
      final Map<String, dynamic> newTrip;

      // get the details from the API.
      final randomResponse = await dio.get(
        'https://en.wikipedia.org/api/rest_v1/page/summary/$randomTrip'
      ) ;
      
      // handle the null response.
      if (randomResponse.data == null){
        emit(HomeInitial());
        return;
      }

      // store the random response data.
      final randomData = randomResponse.data;

      // store the random trip details in the randomTrip.
      newTrip = {
        'title' : randomData['title'] ?? 'Unknown',
        'description' : randomData['extract'] ?? 'No description available',
        'image' : randomData['originalimage']['source'] ?? 'No image to display'
      };

      // list to store the trips.
      final List< Map<String, dynamic> >popularTrips = [];

      // get each trip details.
      for (var city in popularCities){
        final response = await dio.get(
          'https://en.wikipedia.org/api/rest_v1/page/summary/$city'
        );

        // handle the null response.
        if (response.data == null){
          emit(HomeInitial());
          return;
        }

        // store the current trip data.
        final data = response.data as Map<String, dynamic>;

        // add each trip details.
        popularTrips.add({
          'title': data['title'] ?? city,
          'description' : data['extract'] ?? 'No description availavble',
          'image' : data['originalimage']['source'] ?? 'No image to dispaly'
        });
      }

      emit(HomeSuccess(newTrip , popularTrips));
    } catch (e) {
      emit(HomeFailure('Failed to load the tips'));
    }
  }
}