import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  static const String collectionName = "Tasks";
  String? id;
  String? title;
  String? descreption;
  Timestamp? dateTime;
  bool isDone;

  Tasks(
      {this.id,
      this.title,
      this.dateTime,
      this.descreption,
      this.isDone = false});

  Tasks.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?["id"],
          title: data?["title"],
          descreption: data?["descreption"],
          dateTime: data?["dateTime"],
          isDone: data?["isDone"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "descreption": descreption,
      "dateTime": dateTime,
      "isDone": isDone,
    };
  }
}
