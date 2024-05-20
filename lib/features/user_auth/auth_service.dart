

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';


class AuthServices {
  final _auth = FirebaseAuth.instance;


  //Registration
  Future<User?> createUserWithEmailAndPassword(
   String email,String password ) async {
     try{
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
    } catch(e) {
      log("Something went wrong1");
    }
    return null;
  }


    //Login Logic for LoginForm
    Future<User?> loginUserWithEmailAndPassword(
     String email,String password ) async {
     try{
      final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
    } catch(e) {
      log("Something went wrong2");
    }
    return null;
  }


  //Signing Out of App
  Future<void> signout() async {
    try{
      await _auth.signOut();
    } catch(e) {
       log("Something went wrong");
    }
  }
}