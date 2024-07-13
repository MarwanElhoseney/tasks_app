import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/database_manger/model/user.dart' as myUser;

class userDao {
  static CollectionReference<myUser.User> getUserCollection() {
    var db = FirebaseFirestore.instance;
    return db.collection("user").withConverter(
        fromFirestore: (snapshot, options) =>
            myUser.User.fromFireStore(snapshot.data()),
        toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUser(myUser.User user) {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<myUser.User?> getUser(String uid) async {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }

  static Future<myUser.User?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<myUser.User> documentSnapshot =
        await getUserCollection().doc(id).get();
    return documentSnapshot.data();
  }
}
