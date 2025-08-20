


// ---------- Search States ----------

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final Map<String, dynamic> trip; // get the trip.
  SearchSuccess(this.trip);
}

class SearchEmpty extends SearchState {
  final String emptyMessage;
  SearchEmpty(this.emptyMessage);
}

class SearchFailure extends SearchState {
  final String failureMessage;
  SearchFailure(this.failureMessage);
}

// ---------- Search Cubit ----------

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super (SearchInitial());

  // import dio package.
  final dio = Dio();

  // this method will get the searched trip.
  Future<void> getTrip (String destination) async{
    emit(SearchLoading());

    // get the trip from the API.
    try {
      final response = await dio.get('https://en.wikipedia.org/api/rest_v1/page/summary/$destination');
      emit(SearchSuccess(response.data));
    } on DioException catch (e) {
      emit(SearchFailure("Error: $e"));
    }
  }
}