import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void getErrorText(BuildContext context, FirebaseAuthException e) {
  if (e.message == 'Given String is empty or null') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('이메일 또는 패스워드를 입력하세요.'),
      duration: Duration(seconds: 1),
    ));
  } else if (e.message == 'The email address is badly formatted.') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('이메일 형식이 잘못 되었습니다.'),
      duration: Duration(seconds: 1),
    ));
  } else if (e.message == 'Password should be at least 6 characters') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('비밀번호를 6자리 이상 입력해주세요.'),
      duration: Duration(seconds: 1),
    ));
  } else if (e.message ==
      'There is no user record corresponding to this identifier. The user may have been deleted.') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('사용자가 존재하지 않습니다.'),
      duration: Duration(seconds: 1),
    ));
  } else if (e.message ==
      'The password is invalid or the user does not have a password.') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('패스워드가 올바르지 않습니다.'),
      duration: Duration(seconds: 1),
    ));
  } else if (e.message ==
      'The email address is already in use by another account.') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('이미 존재하는 이메일입니다.'),
      duration: Duration(seconds: 1),
    ));
  }
}
