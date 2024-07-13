import 'package:flutter/material.dart';
import 'package:notes_app/database_manger/tasks_dao.dart';
import 'package:notes_app/provider/authontication_provider.dart';
import 'package:notes_app/ui/components/task_item.dart';
import 'package:provider/provider.dart';

class tasksTab extends StatelessWidget {
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<authonticationProvider>(context, listen: false);
    return Column(
      children: [
        StreamBuilder(
          stream:
              tasksDao.getTasksRealTimeUpdates(authProvider.databaseUser!.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              Center(
                child: Column(
                  children: [
                    Text("something went wrong"),
                    ElevatedButton(
                        onPressed: () {}, child: Text("please try again"))
                  ],
                ),
              );
            }
            var tasksList = snapshot.data;
            return Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => tasksItem(
                task: tasksList![index],
              ),
              itemCount: tasksList!.length,
            ));
          },
        )
      ],
    );
  }
}
