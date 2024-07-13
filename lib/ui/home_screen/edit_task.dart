import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database_manger/model/tasks.dart';
import 'package:notes_app/database_manger/tasks_dao.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:provider/provider.dart';

class editTask extends StatelessWidget {
  static String routName = "editScreen";

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as Tasks;
    return Scaffold(
      appBar: AppBar(
        title: Text("edit task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: task.title,
                  onChanged: (value) {
                    task.title = value;
                  },
                  decoration: InputDecoration(
                    label: Text("title"),
                  ),
                ),
                Spacer(),
                TextFormField(
                  onChanged: (value) {
                    task.descreption = value;
                  },
                  initialValue: task.descreption,
                  decoration: InputDecoration(
                    label: Text("descreption"),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () async {
                      task.dateTime = await selectDate(context, task.dateTime);
                    },
                    child: Text("select date")),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: InkWell(
                      onTap: () async {
                        var authProvider = Provider.of<authonticationProvider>(
                            context,
                            listen: false);
                        DialougUtiles.showLoadingDilaogs(
                            context, "wait edit task");
                        await tasksDao.updateTasks(
                            authProvider.databaseUser!.id!, task);
                        DialougUtiles.hideDialougs(context);
                        DialougUtiles.showMessage(context, "editing done",
                            posActionTitles: "ok", posAction: () {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("save changes")),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Timestamp> selectDate(BuildContext context, Timestamp? time) async {
    DateTime? selectDate = await showDatePicker(
        context: context,
        firstDate: time?.toDate() ?? DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectDate != null) {
      return Timestamp.fromDate(selectDate);
    }
    return time ?? Timestamp.now();
  }
}
