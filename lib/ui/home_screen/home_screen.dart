import 'package:flutter/material.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/ui/auth/login.dart';
import 'package:notes_app/ui/home_screen/add_task.dart';
import 'package:notes_app/ui/home_screen/setting_tab/settings_tab.dart';
import 'package:notes_app/ui/home_screen/task_tab/task_tab.dart';

class homeScreen extends StatefulWidget {
  static const String routeName = "home Screen";

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("daily tasks"),
        actions: [
          IconButton(
              onPressed: () {
                authonticationProvider.logOut();
                Navigator.pushReplacementNamed(context, logInScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(color: Theme.of(context).primaryColor, width: 4)),
        onPressed: () {
          addTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 16,
                ),
                label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 16,
                ),
                label: "settings"),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [tasksTab(), settingsTab()];

  void addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => addTask(),
    );
  }
}
