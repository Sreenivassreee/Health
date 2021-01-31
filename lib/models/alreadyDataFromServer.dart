import 'package:cloud_firestore/cloud_firestore.dart';

class alreadyDataFromServer {
  String uid;
  String name;
  String email;
  String photoUrl;
  String mobile;

  alreadyDataFromServer(
      {this.uid, this.name, this.email, this.photoUrl, this.mobile});

  alreadyDataFromServer.fromMap(DocumentSnapshot data)
      : uid = data["id"],
        name = data["name"],
        email = data["email"],
        photoUrl = data["photoUrl"],
        mobile = data["mobile"];
}
