import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/database_manger/model/tasks.dart';
import 'package:notes_app/database_manger/user_dao.dart';

class tasksDao {
  static CollectionReference<Tasks> getTasksCollection(String uid) {
    var userDoc = userDao.getUserCollection().doc(uid);
    return userDoc.collection(Tasks.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            Tasks.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTask(Tasks task, String uid) {
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<Tasks>> getAllTasks(String uid) async {
    var snapShot = await getTasksCollection(uid).get();
    var tasksList = snapShot.docs
        .map(
          (snapShot) => snapShot.data(),
        )
        .toList();
    return tasksList;
  }

  static Stream<List<Tasks>> getTasksRealTimeUpdates(String uid) async* {
    var tasksSnapShots = getTasksCollection(uid).snapshots();
    var tasksList = tasksSnapShots
        .map((tasksCollectionSnapShots) => tasksCollectionSnapShots.docs
            .map(
              (tasksSnapShots) => tasksSnapShots.data(),
            )
            .toList());
    yield* tasksList;
  }

  static deleteTaskFromDatabase(String uid, String id) {
    var taskCollection = getTasksCollection(uid);
    return taskCollection.doc(id).delete();
  }

  static Future<void> updateTasks(String uid, Tasks task) {
    return getTasksCollection(uid).doc(task.id).update(task.toFireStore());
  }
}
