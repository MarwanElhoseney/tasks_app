import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  String text;
  Function onButtonClicked;

  customButton({required this.text, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onButtonClicked();
        },
        child: Text(text));
  }
}
