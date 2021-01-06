import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class Category {
  final int id;
  final String level;
  final String title;
  final String message;
  final String ex;
  Category({this.id, this.level, this.title, this.message, this.ex});
}

Future<dynamic> fireCata() async {
  print("Hitting the FireLevels");
  final usersReference = Firestore.instance.collection("LevelDetails");
  List<Category> datalist = List();
  DocumentSnapshot documentSnapshot =
      await usersReference.document("LevelDetails").get();
  var data = documentSnapshot["LevelDetails-1"];
  // print(data[1]);
  try {
    for (var i = 0; data[i] != null; i++) {
      datalist.add(Category(
        id: data[i]['id'],
        level: data[i]['level'].toString(),
        message: data[i]['Message'].toString(),
        title: data[i]['title'].toString(),
        ex: data[i]['ex'].toString(),
      ));
      // print(i);
    }
  } catch (e) {
    // print(e);
    // print(" datalist $datalist");

    return datalist;
  }
  // print(documentSnapshot["LevelDetails-1"]);
  // print(" datalist $datalist");
  return datalist;
}
