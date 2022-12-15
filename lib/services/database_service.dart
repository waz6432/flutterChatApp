// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mychat/services/auth_service.dart';
import 'package:mychat/services/provider_service.dart';
import 'package:provider/provider.dart';

class DataBaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AuthServices authServices = AuthServices();

  Future<void> addChatRoom({
    String? groupName,
    String? time,
  }) async {
    final docRef = await firebaseFirestore.collection('chats').add(
      {
        'groupName': groupName,
      },
    );

    await docRef.set({
      'id': docRef.id,
      'groupName': groupName,
      'time': time,
      'last message': '',
      'last user': '',
      'last user email': '',
    });
  }

  Future<void> addMessage({
    String? id,
    String? message,
    String? time,
    String? name,
  }) async {
    String uid = await authServices.getUserUid();
    var userName = await firebaseFirestore
        .collection('users')
        .doc(uid)
        .get()
        .then((item) => item.data()!['name']);

    final docRef = await firebaseFirestore
        .collection('chats')
        .doc(id)
        .collection('messages')
        .add(
      {
        'Username': userName,
        'E-mail': FirebaseAuth.instance.currentUser!.email,
        'Message': message,
        'Time': time,
      },
    );

    await docRef.set({
      'id': id,
      'Username': userName,
      'E-mail': FirebaseAuth.instance.currentUser!.email,
      'Message': message,
      'Time': time,
    }).then((_) => firebaseFirestore.collection('chats').doc(id).update(
          {
            'last message': message,
            'last user': userName,
            'last user email': FirebaseAuth.instance.currentUser!.email,
            'time': time,
          },
        ));
  }

  void delete(BuildContext context, int index) async {
    final ref = context.read<ProviderService>();
    await firebaseFirestore
        .collection('chats')
        .doc(ref.chats[index]['id'])
        .delete();
  }
}
