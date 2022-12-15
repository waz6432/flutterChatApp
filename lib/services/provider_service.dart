import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ProviderService extends ChangeNotifier {
  List<Contact> contacts = [];
  List<DocumentSnapshot> chats = [];

  void getContactPermission() async {
    try {
      if (!await FlutterContacts.requestPermission(readonly: true)) {
        exit(0);
      } else {
        fetchContacts();
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchContacts() async {
    contacts = await FlutterContacts.getContacts();
    notifyListeners();
  }

  int get contactsLength {
    return contacts.length;
  }

  String getUserName(int index) {
    String name = contacts[index].displayName;
    return name;
  }

  double getScreenHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return height;
  }

  double getScreenWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return width;
  }
}
