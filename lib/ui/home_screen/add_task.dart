import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database_manger/model/tasks.dart';
import 'package:notes_app/database_manger/tasks_dao.dart';
import 'package:notes_app/ui/components/custom_boutton.dart';
import 'package:notes_app/ui/components/text_form_field.dart';
import 'package:notes_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:provider/provider.dart';

import '../../provider/authontication_provider.dart';

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text("Add Task",
                    style: Theme.of(context).textTheme.labelSmall)),
            customFiled(
              controller: titleController,
              textFiled: "Task Title",
              validate: (input) {
                if (input == null || input.trim().isEmpty) {
                  return "Plz enter task ";
                }
                ;

                return null;
              },
            ),
            customFiled(
                controller: descriptionController,
                textFiled: "Task Descreption",
                maxlines: 4,
                validate: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return "Plz enter task description";
                  }
                  ;

                  return null;
                }),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(finalSelectedDate == null
                    ? "select date"
                    : "${finalSelectedDate?.day}/${finalSelectedDate?.month}/${finalSelectedDate?.year}")),
            Visibility(
                visible: showDateError,
                child: Text(
                  "PLZ SELECTED DATE",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task")),
          ],
        ),
      ),
    );
  }

  bool isValidForm() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (finalSelectedDate == null) {
      setState(() {
        showDateError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  addTask() async {
    var authProvider =
        Provider.of<authonticationProvider>(context, listen: false);
    if (!isValidForm()) {
      return;
    }
    Tasks task = Tasks(
        dateTime: Timestamp.fromMicrosecondsSinceEpoch(
            finalSelectedDate!.millisecondsSinceEpoch),
        descreption: descriptionController.text,
        title: titleController.text);
    try {
      DialougUtiles.showLoadingDilaogs(context, "loading");
      await tasksDao.addTask(task, authProvider.databaseUser!.id!);
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, "task added successfully",
          posActionTitles: "ok", posAction: () {
        Navigator.pop(context);
      });
    } catch (e) {
      DialougUtiles.hideDialougs(context);
      DialougUtiles.showMessage(context, "something wrong,${e.toString()}");
    }
  }

  DateTime? finalSelectedDate;
  bool showDateError = false;

  void showTaskDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (date != null) {
      finalSelectedDate = date;
      showDateError = false;
      setState(() {});
    }
  }
}
