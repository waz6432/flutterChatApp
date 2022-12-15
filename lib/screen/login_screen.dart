import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mychat/components/custom_textfield.dart';
import 'package:mychat/components/rounded_button.dart';
import 'package:mychat/screen/register_screen.dart';
import 'package:mychat/services/auth_service.dart';
import 'package:mychat/services/provider_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderService>().getContactPermission();
    });
  }

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
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome back',
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 30),
                        ),
                      ],
                    ),
                    Text(
                      'Welcome Back! Please enter your details',
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
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter your email',
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
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.06),
                    RoundedButton(
                      buttonName: 'Sign in',
                      onPressed: () {
                        AuthServices().signInWithEmailAndPassword(
                            context, email, password);
                      },
                    ),
                    SizedBox(
                        height: screenData.getScreenHeight(context) * 0.03),
                    RoundedButton(
                      buttonName: 'Sign up',
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
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
