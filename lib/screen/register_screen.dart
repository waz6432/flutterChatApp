import 'package:flutter/material.dart';
import 'package:mychat/components/custom_textfield.dart';
import 'package:mychat/components/rounded_button.dart';
import 'package:mychat/services/auth_service.dart';
import 'package:mychat/services/provider_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'RegisterScreen';
  String email = '';
  String password = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<ProviderService>(
            builder: (context, screenData, child) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenData.getScreenWidth(context) * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'START FOR FREE',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.05),
                    Text('Email'),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.01),
                    CustomTextField(
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.03),
                    Text('Password'),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.01),
                    CustomTextField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Enter your password',
                      onChanged: (value) {
                        password = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.03),
                    Text('Name'),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.01),
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      hintText: 'Enter your name',
                      onChanged: (value) {
                        name = value;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.06),
                    RoundedButton(
                      buttonName: 'Sign up',
                      onPressed: () async {
                        AuthServices().createUserWithEmailAndPassword(
                          context,
                          email,
                          password,
                          name,
                        );
                      },
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.03),
                    RoundedButton(
                      buttonName: 'Sign in',
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
