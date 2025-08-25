

import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  static String? get uid =>  FirebaseAuth.instance.currentUser?.uid; 
  static String? get uEmail =>  FirebaseAuth.instance.currentUser?.email; 
}
