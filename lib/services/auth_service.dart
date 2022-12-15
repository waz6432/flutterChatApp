// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychat/error_text.dart';
import 'package:mychat/screen/chat_list_screen.dart';
import 'package:mychat/screen/login_screen.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? uid;
  User? loggedUser;
  User? user;

  void createUserWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      final newUser = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.user!.uid)
            .set({
          'name': name,
          'email': email,
          'password': password,
          'comment': '',
        });
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      getErrorText(context, e);
    }
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, ChatList.id, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      getErrorText(context, e);
    }
  }

  void signOutUser(BuildContext context) async {
    try {
      user = await firebaseAuth.currentUser;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
        firebaseAuth.signOut();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserUid() async {
    try {
      uid = await firebaseAuth.currentUser!.uid;
    } catch (e) {
      print(e);
    }

    return uid ?? '';
  }
}
