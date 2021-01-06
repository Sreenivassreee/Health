import 'package:Health/Services/Global.dart';
import 'package:Health/Services/Preferences.dart';
import 'package:Health/models/alreadyDataFromServer.dart';
import 'package:Health/models/error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("Users");

class Fire {
  static Future<String> UpDateDetails(
      {user, age, email, phoneNumber, context}) async {
    String _mess;

    try {
      print("currentAccount.id ${user.email}");
      // DocumentSnapshot documentSnapshot =
      //     await usersReference.document(user.email).get();

      if (email == user.email) {
        Pref.saveLoginStatusPrif();
        _mess = "AlreadyUser";
        usersReference.document(user.email).setData({
          "id": user.uid,
          "name": user.displayName,
          "email": user.email,
          "photoUrl": user.photoUrl,
          "mobile": phoneNumber,
          "age": age,
        });

        await FirePref.initialFirebasePrefSave(user);
      } else {
        return "invalid";
        // documentSnapshot = await usersReference.document(user.email).get();
      }
      // return alreadyDataFromServer.fromMap(documentSnapshot);
    } catch (e) {
      print(e);
      // logOut(context).whenComplete(() => ErrorPage(context: context));
    }
  }

  static Future<alreadyDataFromServer> fireBaseUserData(
      {email, context}) async {
    DocumentSnapshot document = await usersReference.document(email).get();

    print(" id in 1 $email");

    if (document.exists) {
      print("Document is There");
      DocumentSnapshot documentSnapshot =
          await usersReference.document(email).get();
      // print(alreadyDataFromServer.fromMap(documentSnapshot).email);
      if (email == alreadyDataFromServer.fromMap(documentSnapshot).email) {
        return alreadyDataFromServer.fromMap(documentSnapshot);
      }
      return null;
    } else {
      print("No Document");
      return null;
    }
  }

  static Future<String> fireUpdaeScoreAndLevel(
      String id, int upLevel, int upScore) async {
    String _mess;
    // DocumentSnapshot documentSnapshot =
    //     await usersReference.document(id).get();

    // if (documentSnapshot.exists) {
    // _mess = "AlreadyUser";
    //   documentSnapshot = await usersReference.document(user.id).get();
    //   return alreadyDataFromServer.fromMap(documentSnapshot);
    // } else {

    try {
      usersReference.document(id).updateData({
        "currentLevel": upLevel,
        "currentScore": upScore,
      });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> fireUpdaeScore(String id, int upScore) async {
    String _mess;
    final usersReference = Firestore.instance.collection("Users");

    try {
      usersReference.document(id).updateData({
        "currentScore": upScore,
      });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> updateLevelPercentageFire(
      String id, int level, String per) async {
    String _mess;
    print("Per $per");
    // DocumentSnapshot documentSnapshot = await usersReference
    //     .document(id)
    //     .collection("LevelPercentages")
    //     .document("LevelByPer")
    //     .get();
    // var a = documentSnapshot.data["LevelByPer"];

    // print("documentSnapshot.data${a}");

    // if (documentSnapshot.exists) {
    try {
      Firestore.instance
          .collection("Users")
          .document(id)
          .collection("LevelPercentages")
          .document("LevelByPer")
          .setData({
        // "LevelByPer": FieldValue.arrayUnion([
        level.toString(): {
          "Level": level,
          "percentage": per.toString(),
        }
        // ])
      }, merge: true);

      // )
      // .document(level.toString())
      // .updateData
      // ({
      // "level": level,
      // "percentage": per.toString(),
      // });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    // } else {
    // try {
    //   usersReference
    //       .document(id)
    //       .collection("LevelPercentages")
    //       .document("LevelByPer")
    //       .updateData({
    //     // "LevelByPer": FieldValue.arrayUnion([
    //       {
    //         "Level": level,
    //         "percentage": per.toString(),
    //       }
    //     // ])
    //   }, merge: true);
    // usersReference
    //     .document(id)
    //     .collection("LevelPercentages")
    //     .document(level.toString())
    //     .setData({
    //   "level": level,
    //   "percentage": per.toString(),
    // });
    // _mess = "Sucess";
    // } catch (e) {
    //   _mess = "Failed";
    // }
    // }

    return _mess;
  }

  // fetchLevels(id) {
  //   Future<QuerySnapshot> data=usersReference.document(id).collection("LevelPercentages").getDocuments();
  //   if(data!=null){
  //     levelPer.fromMap(QuerySnapshot).toList();
  //   }
  // }

  static Future<String> updateProfile({
    String userId,
    String name,
    String mobile,
    String pin,
    String state,
    String quali,
  }) async {
    String _mess;
    try {
      usersReference.document(userId).updateData({
        "name": name,
        "mobile": mobile,
        "state": state,
        "qualification": quali,
        "pin": pin,
      });

      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> saveAbout({String userId, String about}) async {
    print(userId);
    String _mess;
    try {
      usersReference.document(userId).updateData(
        {
          "about": about.toString(),
        },
      );
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }
}
