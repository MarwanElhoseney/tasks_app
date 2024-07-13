

class User {
  String? id;
  String? fullName;
  String? emailAdress;
  String? userName;

  User({this.emailAdress, this.fullName, this.id, this.userName});

  User.fromFireStore(Map<String, dynamic>? data)
      : this(
          emailAdress: data?["emailAdress"],
          id: data?["id"],
          userName: data?["userName"],
          fullName: data?["fullName"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "fullName": fullName,
      "emailAdress": emailAdress,
      "userName": userName,
    };
  }
}
