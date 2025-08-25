


// -------- auth states --------

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/core/data/shared_preference.dart';
import 'package:travel_app/core/data/user_helper.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String failureMessage;
  AuthFailure(this.failureMessage);
}

// -------- auth cubit --------

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super (AuthInitial());
  
  // store the firebaseAuth instance.
  final _auth = FirebaseAuth.instance;

  // register method.
  Future<void> register (String name, String email, String password) async{
    emit (AuthLoading());
    try {
      // register the user.
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // save the user data in a document.
      await FirebaseFirestore.instance.collection('users').doc(UserHelper.uid).set(
        {
          'name' : name,
          'email' : email,
          'avatar' : ''
        }
      );
      emit(AuthSuccess());
      SharedPreferenceHelper().setString('uEmail', email);
    } on FirebaseAuthException catch (e) {
      emit (AuthFailure('Error: $e'));
    }
  }

  // login method.
  Future<void> login (String email, String password) async{
    emit (AuthLoading());

    try {
      // login the user.
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
      SharedPreferenceHelper().setString('uEmail', email);
    } on FirebaseAuthException catch (e) {
      emit (AuthFailure('Error: $e'));
    }
  }
}