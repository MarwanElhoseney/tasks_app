import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/ui/auth/login.dart';

class splashScreen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, logInScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
