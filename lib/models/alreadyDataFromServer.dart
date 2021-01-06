import 'package:cloud_firestore/cloud_firestore.dart';

class alreadyDataFromServer {
  String uid;
  String name;
  String email;
  String photoUrl;
  String mobile;
  String state;
  String qualification;
  int current_level;
  int current_score;
  String uStatus;
  String pin;
  String about;

  alreadyDataFromServer(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.mobile,
      this.state,
      this.qualification,
      this.current_score,
      this.current_level,
      this.uStatus,
      this.pin,
      this.about});

  alreadyDataFromServer.fromMap(DocumentSnapshot data)
      : uid = data["id"],
        name = data["name"],
        email = data["email"],
        photoUrl = data["photoUrl"],
        mobile = data["mobile"],
        state = data["state"],
        qualification = data["qualification"],
        current_level = data["currentLevel"],
        current_score = data["currentScore"],
        uStatus = data['status'],
        pin = data['pin'],
        about = data['about'];
}
