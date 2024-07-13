import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app/database_manger/model/tasks.dart';
import 'package:notes_app/database_manger/tasks_dao.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/ui/home_screen/edit_task.dart';
import 'package:notes_app/utiles/dialogs_utils/dilaogs.dart';
import 'package:provider/provider.dart';

class tasksItem extends StatefulWidget {
  Tasks task;

  tasksItem({required this.task});

  @override
  State<tasksItem> createState() => _tasksItemState();
}

class _tasksItemState extends State<tasksItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .2,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => (removedTask(widget.task)),
            //;عشان التاسك بره البيلد

            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "delete",
            foregroundColor: Colors.white,
          )
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => (Navigator.pushNamed(
                context, editTask.routName,
                arguments: widget.task)),
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            label: "edit",
            foregroundColor: Colors.white,
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 60,
              decoration: BoxDecoration(
                  color: widget.task.isDone ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.task.title ?? "",
                    style: TextStyle(
                      color: widget.task.isDone ? Colors.green : Colors.black,
                    ),
                  ),
                  Text(
                    widget.task.descreption ?? '',
                    style: TextStyle(
                      color: widget.task.isDone ? Colors.green : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            widget.task.isDone
                ? InkWell(
                    onTap: () async {
                      var authProvider = Provider.of<authonticationProvider>(
                          context,
                          listen: false);
                      widget.task.isDone = !widget.task.isDone;
                      await tasksDao.updateTasks(
                          authProvider.databaseUser!.id!, widget.task);
                      setState(() {});
                    },
                    child: Text(
                      "Is Done",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      var authProvider = Provider.of<authonticationProvider>(
                          context,
                          listen: false);
                      widget.task.isDone = !widget.task.isDone;
                      await tasksDao.updateTasks(
                          authProvider.databaseUser!.id!, widget.task);
                      setState(() {});
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                  )
          ],
        ),
      ),
    );
  }

  void removedTask(Tasks task) {
    DialougUtiles.showMessage(context, "Are U Sure U Want To Delete This Task",
        posActionTitles: "confirm",
        posAction: deleteTask(task),
        negActionTitles: "no");
  }

  deleteTask(Tasks task) async {
    var authProvider =
        Provider.of<authonticationProvider>(context, listen: false);

    await tasksDao.deleteTaskFromDatabase(
        authProvider.databaseUser!.id!, task.id!);
    DialougUtiles.hideDialougs(context);
    DialougUtiles.showMessage(context, "Task Deleted Successfully",
        posActionTitles: "ok");
  }
}
