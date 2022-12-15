import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({this.buttonName, @required this.onPressed});

  final String? buttonName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50.0,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: onPressed,
      color: Colors.lightBlueAccent,
      child: Text(
        buttonName!,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
