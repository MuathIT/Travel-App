


// ---------- Search States ----------

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchEmpty extends SearchState {
  final String emptyMessage;
  SearchEmpty(this.emptyMessage);
}

// state for the trip details.
class SearchSuccess extends SearchState {
  final Map<String, dynamic> trip; // get the trip.
  SearchSuccess(this.trip);
}

// state for the live suggestions.
class SearchSuggestions extends SearchState {
  final List<String> suggestions; // get the suggestions.
  SearchSuggestions(this.suggestions);
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

  // this method will give the user suggestions while he types.
  Future<void> getSuggestions (String query) async{
    // handle the empty.
    if (query.isEmpty){
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    // get the suggetions from the API.
    try {
      final response = await dio.get(
        'https://en.wikipedia.org/w/api.php',
        queryParameters: { // to give suggestions while user types.
          "action" : "opensearch", // search type.
          "search" : query, // the current query value.
          "limit" : 10, // the first 10 trips.
          "format" : "json" // the response format.
        }
      );

      // final response = await dio.get( 
      //   'https://api.allorigins.win/get?url=${Uri.encodeComponent('https://en.wikipedia.org/w/api.php?action=opensearch&search=$query&limit=10&format=json')}'
      // ); // this for CROS proxy in web.

      // get the suggestions.
      final List suggestions = response.data[1];

      // handle the empty suggestions.
      if (suggestions.isEmpty){
        emit(SearchEmpty('No suggestions found'));
      }
      else{
        emit(SearchSuggestions(List<String>.from(suggestions))); // convert the list from dynamic to string and then send it to the state.
      }
      
    } on DioException catch (e) {
      emit(SearchFailure("Error: ${e.message}"));
    } catch (e) {
      emit(SearchFailure('Unexpected error: $e'));
    }
  }

  // this method will get the searched trip.
  Future<void> getTrip (String destination) async{

    // handle the empty.
    if (destination.isEmpty){
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    // get the trip from the API.
    try {
      final response = await dio.get(
        'https://en.wikipedia.org/api/rest_v1/page/summary/$destination'
      );

      // handle the null response.
      if (response.data == null){
        emit(SearchEmpty('No Trip found for $destination'));
        return;
      }

      // get the data as map of string and dynamic.
      final data = response.data as Map<String, dynamic>;

      // handle the empty data.
      if (data.isEmpty){
        emit(SearchEmpty('No Trip found for $destination'));
        return;
      }

      // extract the needed fields & handle their null values.
      final trip = {
        'title' : data['title'] ?? 'Unknown',
        'description' : data['extract'] ?? 'No description available' ,
        'image' : data['originalimage']['source'] ?? 'No image to display'
      };
      emit(SearchSuccess(trip));

    } on DioException catch (e) {
      emit(SearchFailure("Error: ${e.message}"));
    } catch (e) {
      emit(SearchFailure('Unexpected error: $e'));
    }
    
  }
}