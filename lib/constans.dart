import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

const kProfileFieldDecoration = InputDecoration(
  isDense: true,
  hintText: 'Enter your profile',
  hintStyle: TextStyle(
    color: Colors.white70,
    fontSize: 20.0,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: 0.6,
      color: Colors.white,
    ),
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 30.0,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 1.0,
    ),
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: Colors.lightBlueAccent,
      width: 2.0,
    ),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  border: InputBorder.none,
  hintText: 'Send a message',
  contentPadding: EdgeInsets.symmetric(
    horizontal: 10.0,
  ),
);
