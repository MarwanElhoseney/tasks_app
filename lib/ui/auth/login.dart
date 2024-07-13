import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/firebase_core.dart';
import 'package:notes_app/database_manger/user_dao.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/ui/auth/regestretion.dart';
import 'package:notes_app/ui/components/custom_boutton.dart';
import 'package:notes_app/ui/components/text_form_field.dart';
import 'package:notes_app/ui/home_screen/home_screen.dart';
import 'package:notes_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:notes_app/utiles/email_validator.dart';
import 'package:provider/provider.dart';

class logInScreen extends StatefulWidget {
  static const String routeName = "signInScreen";

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  TextEditingController emailController =
      TextEditingController(text: "marwan@gmail.com");

  TextEditingController passwordController =
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
            "LogIn",
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
                customButton(text: "Sign_in", onButtonClicked: signIn),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, regesterScreen.routeName);
                    },
                    child: Text("Don't Have Acount?Create Acount")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    var authProvider =
        Provider.of<authonticationProvider>(context, listen: false);
    if (formKey.currentState!.validate() == false) {
      return;
    }
    try {
      DialougUtiles.showLoadingDilaogs(context, "loading....");
      await authProvider.login(emailController.text, passwordController.text);
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, "user login sucssefully",
          posActionTitles: "yes", posAction: () {
        Navigator.pushReplacementNamed(context, homeScreen.routeName);
      }, isDismissable: false);
    } on FirebaseAuthException catch (e) {
      DialougUtiles.hideDialougs(context);
      if (e.code == fireBaseErrorCore.userNotFound ||
          e.code == fireBaseErrorCore.wrongPassword) {
        DialougUtiles.showMessage(context, 'wrong email or password',
            posActionTitles: "try again", posAction: () {});
      }
    } catch (e) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, e.toString());
    }
  }
}
