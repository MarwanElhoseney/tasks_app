import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/firebase_core.dart';
import 'package:notes_app/database_manger/model/user.dart' as myUser;
import 'package:notes_app/database_manger/user_dao.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/ui/auth/login.dart';
import 'package:notes_app/ui/components/text_form_field.dart';
import 'package:notes_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:notes_app/utiles/email_validator.dart';
import 'package:provider/provider.dart';

class regesterScreen extends StatefulWidget {
  static const String routeName = "regesterScreen";

  @override
  State<regesterScreen> createState() => _regesterScreenState();
}

class _regesterScreenState extends State<regesterScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: "marwan mahmoud");

  TextEditingController userNameController =
      TextEditingController(text: "marwan ");

  TextEditingController emailController =
      TextEditingController(text: "marwan@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "12345678");

  TextEditingController confirmPasswordController =
      TextEditingController(text: "12345678");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjk5Ni0wMDlfMS1rcm9pcjRkay5qcGc.webp"))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customFiled(
                    textFiled: "Full Name",
                    controller: fullNameController,
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter full name";
                      }
                      if (input.length < 8) {
                        return "name must br 8 chars";
                      }
                      return null;
                    }),
                customFiled(
                  textFiled: "User Name",
                  controller: userNameController,
                  validate: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Plz enter user name";
                    }
                    return null;
                  },
                ),
                customFiled(
                    textFiled: "Email",
                    controller: emailController,
                    keyBoardType: TextInputType.emailAddress,
                    validate: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Plz enter email";
                      }
                      ;
                      if (!isValidEmail(input)) {
                        return "enter valid email";
                      }
                      ;
                      return null;
                    }),
                customFiled(
                  textFiled: "Password",
                  controller: passwordController,
                  keyBoardType: TextInputType.visiblePassword,
                  isobscure: true,
                  validate: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Plz enter password";
                    }
                    ;
                    if (input.length < 8) {
                      return "password must be at least 8 chars";
                    }
                    return null;
                  },
                ),
                customFiled(
                  textFiled: "Confirm Password",
                  controller: confirmPasswordController,
                  keyBoardType: TextInputType.visiblePassword,
                  isobscure: true,
                  validate: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Plz enter password";
                    }
                    ;
                    if (input != passwordController.text) {
                      return "password not match";
                    }
                    return null;
                  },
                ),
                //
                // customButton(text: "Sign-Up", onButtonClicked: signUp)
                ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, logInScreen.routeName);
                    },
                    child: Text("already have account?sign_in")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    var authProvider =
        Provider.of<authonticationProvider>(context, listen: false);
    if (formKey.currentState!.validate() == false) {
      return;
    }
    try {
      DialougUtiles.showLoadingDilaogs(context, "loading...");
      await authProvider.regester(emailController.text, passwordController.text,
          fullNameController.text, userNameController.text);
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, "user sign_up sucssefully",
          posActionTitles: "next", posAction: () {
        Navigator.pushReplacementNamed(context, logInScreen.routeName);
      }, isDismissable: false);
    } on FirebaseAuthException catch (e) {
      if (e.code == fireBaseErrorCore.weakPassword) {
        DialougUtiles.hideDialougs(context);
        DialougUtiles.showMessage(
          context,
          " weak password",
          posActionTitles: "try again",
        );
      } else if (e.code == fireBaseErrorCore.emailAlreadyUse) {
        DialougUtiles.hideDialougs(context);
        DialougUtiles.showMessage(
          context,
          " email already use",
          posActionTitles: "try again",
        );
      }
    } catch (e) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(
        context,
        e.toString(),
        posActionTitles: "try again",
      );
    }
  }
}
