import 'package:flutter/material.dart';

typedef validator = String? Function(String?);

class customFiled extends StatelessWidget {
  String textFiled;
  TextInputType keyBoardType;

  bool isobscure;
  validator? validate;
  TextEditingController? controller;
  int maxlines;

  customFiled(
      {required this.textFiled,
      this.keyBoardType = TextInputType.text,
      this.isobscure = false,
      this.validate,
      this.controller,
      this.maxlines = 1});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: keyBoardType,
        obscureText: isobscure,
        maxLines: maxlines,
        minLines: maxlines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: textFiled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
