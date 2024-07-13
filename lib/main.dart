import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/styles/theming/my_theme.dart';
import 'package:notes_app/ui/auth/login.dart';
import 'package:notes_app/ui/auth/regestretion.dart';
import 'package:notes_app/ui/home_screen/edit_task.dart';
import 'package:notes_app/ui/home_screen/home_screen.dart';
import 'package:notes_app/ui/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => authonticationProvider(), child: myApp()));
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<authonticationProvider>(context);
    return MaterialApp(
      theme: myTheme.lightTheme,
      darkTheme: myTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        regesterScreen.routeName: (context) => regesterScreen(),
        logInScreen.routeName: (context) => logInScreen(),
        homeScreen.routeName: (context) => homeScreen(),
        splashScreen.routeName: (context) => splashScreen(),
        editTask.routName: (context) => editTask()
      },
      initialRoute: authProvider.firebaseAuthUser != null
          ? homeScreen.routeName
          : logInScreen.routeName,
    );
  }
}
