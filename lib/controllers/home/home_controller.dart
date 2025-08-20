
// ---------- Home States ----------
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeSuccess extends HomeState{
  final List< Map<String, dynamic> >trips;
  HomeSuccess(this.trips);
}

class HomeFailure extends HomeState{
  final String failureMessage;
  HomeFailure(this.failureMessage);
}

// ---------- Home Cubit ----------
class HomeCubit extends Cubit<HomeState> {
  HomeCubit () : super (HomeInitial());

  final Dio dio = Dio();

  // this method will get the popular trips.
  Future<void> loadHomeTrips () async{
    emit(HomeLoading());

    try {
      // list of the popular trips titles.
      final popularTrips = [
        'Bangkok', 
        'London', 
        'Paris', 
        'Dubai', 
        'Singapore', 
        'New York City', 
        'Istanbul', 
        'Tokyo', 
        'Cape Town', 
        'Melbourne', 
        'Iceland', 
        'Barcelona'
      ];

      // list to store the trips.
      final List< Map<String, dynamic> >homeTrips = [];

      // get each trip details.
      for (var trip in popularTrips){
        final response = await dio.get(
          'https://en.wikipedia.org/api/rest_v1/page/summary/$trip'
        );

        // handle the null response.
        if (response.data == null){
          emit(HomeInitial());
          return;
        }
        // store the current trip data.
        final data = response.data as Map<String, dynamic>;
        // handle the empty data.
        if (data.isEmpty){
          emit(HomeInitial());
          return;
        }
        // add each trip details.
        homeTrips.add({
          'title': data['title'] ?? trip,
          'description' : data['extract'] ?? 'No description availavble',
          'image' : data['originalimage']['source'] ?? 'No image to dispaly'
        });
      }

      emit(HomeSuccess(homeTrips));
    } catch (e) {
      emit(HomeFailure('Failed to load the tips'));
    }
  }
}