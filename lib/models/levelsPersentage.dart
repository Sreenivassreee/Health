import 'package:cloud_firestore/cloud_firestore.dart';

class levelPer {
  int level;
  String per;

  levelPer({this.level, this.per});

  levelPer.fromMap(Map<String, dynamic> data)
      : level = data["level"],
        per = data["percentage"];
}
