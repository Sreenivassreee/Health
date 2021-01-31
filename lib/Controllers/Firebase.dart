import 'package:Health/Controllers/Preferences.dart';
import 'package:Health/models/alreadyDataFromServer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:intl/intl.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("Users");

class Fire {
  static Future<String> UpDateDetails(
      {user, age, email, phoneNumber, context}) async {
    String _mess;

    try {
      print("currentAccount.id ${user.email}");

      if (email == user.email) {
        dammi(user.email);
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

  static Future<bool> whatsAppNotifications(email, status) async {
    bool Sstatus = null;
    print(status);
    await usersReference
        .document(email)
        .collection('EachPara')
        .document('Notifications')
        .updateData({"whatsapp": !status}).whenComplete(
            () => {Sstatus = status});
    return Sstatus;
  }

  static mailNotifications(email, status) async {
    await usersReference
        .document(email)
        .collection('EachPara')
        .document('Notifications')
        .updateData({"mail": !status});
  }

  static smsNotifications(email, status) async {
    await usersReference
        .document(email)
        .collection('EachPara')
        .document('Notifications')
        .updateData({"sms": !status});
  }

  static dammi(email) async {
    try {
      DocumentSnapshot document1 = await usersReference
          .document(email)
          .collection('EachPara')
          .document('DocumentDetails')
          .get();
      if (document1.data == null) {
        await usersReference
            .document(email)
            .collection('EachPara')
            .document('DocumentDetails')
            .setData({});
      }
      DocumentSnapshot document2 = await usersReference
          .document(email)
          .collection('EachPara')
          .document('Notifications')
          .get();
      if (document2.data == null) {
        await usersReference
            .document(email)
            .collection('EachPara')
            .document('Notifications')
            .setData({"mail": false, "whatsapp": false, "sms": false});
      }
      DocumentSnapshot document3 = await usersReference
          .document(email)
          .collection('EachPara')
          .document('diseases')
          .get();
      if (document3.data == null) {
        await usersReference
            .document(email)
            .collection('EachPara')
            .document('diseases')
            .setData({});
      }
      DocumentSnapshot document4 = await usersReference
          .document(email)
          .collection('EachPara')
          .document('EachPara')
          .get();
      if (document4.data == null) {
        await usersReference
            .document(email)
            .collection('EachPara')
            .document('EachPara')
            .setData({});
      }
    } catch (e) {}
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

  static Future<String> documentUrlToFireStore(
      {String url,
      String email,
      String name,
      String description,
      String date,
      String decOfDoc,
      String nameOfDoc}) async {
    String _mess;
    final DateTime now = DateTime.now();

    String date = DateFormat('yyyy-MM-dd').format(now);
    // DocumentSnapshot documentSnapshot =
    //     await usersReference.document(id).get();

    // if (documentSnapshot.exists) {
    // _mess = "AlreadyUser";
    //   documentSnapshot = await usersReference.document(user.id).get();
    //   return alreadyDataFromServer.fromMap(documentSnapshot);
    // } else {

    try {
      usersReference
          .document(email)
          .collection('EachPara')
          .document('DocumentDetails')
          .collection("Docs")
          .document()
          .setData({
        "DocUrl": url,
        "Name": name ?? "Server Error",
        "Description": description ?? "Server Error",
        "Date": date
      });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  // fetchLevels(id) {
  //   Future<QuerySnapshot> data=usersReference.document(id).collection("LevelPercentages").getDocuments();
  //   if(data!=null){
  //     levelPer.fromMap(QuerySnapshot).toList();
  //   }
  // }

  static Future<String> updateProfile(
      {String userId,
      String name,
      String mobile,
      String age,
      String email}) async {
    String _mess;
    try {
      usersReference.document(email).updateData({
        "name": name,
        "mobile": mobile,
        "age": age,
      });

      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }
}
