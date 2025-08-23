

// ---------- Favorite State ----------

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {}

class FavoriteFailure extends FavoriteState {
  final String failureMessage;
  FavoriteFailure (this.failureMessage);
}

// ---------- Favorite Cubit ----------

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit () : super (FavoriteInitial());

  // this method will add the trip to the favorite list.
  Future<void> addToFavorite (Map<String, dynamic> trip) async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // add the given trip to the user favorite list (collection).
    try {
      await FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .collection('favorites')
      .add(
        {
          'title' : trip['title'],
          'description' : trip['description'],
          'image' : trip['image'],
          'rating' : trip['rating']
        }
      );
      emit(FavoriteSuccess());
    } catch (e) {
      emit(FavoriteFailure("Error: Couldn't add the trip to your favorites"));
    }
  }
  
  // this method will remove the trip to the favorite list.
  Future<void> removeFromFavorite (String tripId) async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // remove the given trip ID from the collection.
    try {
      await FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .collection('favorites')
      .doc(tripId)
      .delete();

      emit(FavoriteSuccess());
    } catch (e) {
      emit(FavoriteFailure("Error: Couldn't remove the trip from your favorites"));
    }
  }
}