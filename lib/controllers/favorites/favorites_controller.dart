
// ---------- Favorites State ----------
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List favoriteTrips; // get the favorite trips.
  FavoritesSuccess(this.favoriteTrips);
}

class FavoritesEmpty extends FavoritesState {
  final String emptyMessage;
  FavoritesEmpty (this.emptyMessage);
}

class FavoritesFailure extends FavoritesState {
  final String failureMessage;
  FavoritesFailure (this.failureMessage);
}

// ---------- Favorites Cubit ----------
class FavoritesCubit extends Cubit<FavoritesState>{
  FavoritesCubit () : super (FavoritesInitial());

  StreamSubscription? _favoritesSub; // for cancelation & handling multiple listeners..

  // start listening to Firestore favorites in real-time
  Future<void> getFavTrips() async {
    emit(FavoritesLoading());

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      emit(FavoritesFailure("User not logged in"));
      return;
    }

    try {
      _favoritesSub?.cancel(); // cancel any old subscription before creating new

      _favoritesSub = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .snapshots()
          .listen((snapshot) {
        final trips = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id; // keep doc id for easy add/remove later
          return data;
        }).toList();

        if (trips.isEmpty) {
          emit(FavoritesEmpty("You don't have favorite trips yet"));
        } else {
          emit(FavoritesSuccess(trips));
        }
      }, onError : (e) { // handle the listen error.
        emit(FavoritesFailure("Error: $e"));
      });
    } catch (e) {
      emit(FavoritesFailure("Error: $e"));
    }
  }

  // clean up the Firestore subscription
  @override
  Future<void> close() {
    _favoritesSub?.cancel();
    return super.close();
  }

  // this method will tell if the trip is added or not.
  // bool isFavorited (String tripTitle){
  //   if (state is FavoritesLoading){
  //     return (state as FavoritesSuccess)
  //     .favoriteTrips
  //     .any((trip) => trip['title'] == tripTitle); // checks if the given trip id is already in the favorites list.
  //   }
  //   return false;
  // }
}