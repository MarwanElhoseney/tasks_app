import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database_manger/model/user.dart' as myUser;
import 'package:notes_app/database_manger/user_dao.dart';

class authonticationProvider extends ChangeNotifier {
  myUser.User? databaseUser;
  User? firebaseAuthUser;

  Future<void> regester(
      String email, String password, String fullName, String userName) async {
    UserCredential result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    myUser.User user = myUser.User(
      id: result.user!.uid,
      emailAdress: email,
      fullName: fullName,
      userName: userName,
    );
    await userDao.addUser(user);
  }

  Future<void> login(String email, String Password) async {
    UserCredential result =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: Password,
    );
    databaseUser = await userDao.getUser(result.user!.uid);
    firebaseAuthUser = result.user;
  }

  authonticationProvider() {
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    if (firebaseAuthUser != null) {
      initUser();
    }
  }

  initUser() async {
    databaseUser = await userDao.readUser();
    notifyListeners();
  }

  static void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
