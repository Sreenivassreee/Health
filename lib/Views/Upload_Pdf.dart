import 'dart:io';
import 'dart:math';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:Health/Services/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadPdf extends StatefulWidget {
  String email;
  UploadPdf(this.email);
  @override
  _UploadPdfState createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  String formattedDate, date2;
  TextEditingController nameOfDoc = TextEditingController();
  TextEditingController desOfDoc = TextEditingController();
  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();

    formattedDate = DateFormat('kk:mm:ss__EEE_d_MMM_yyyy_MM_dd').format(now);
    date2 = DateFormat('kk:mm:ss EEE d MMM yyyy-MM-dd').format(now);

    // final String formatted = formattedDate.format(now);
    print("formatte  " + formattedDate); // something like 2013-04-20
  }

  downloadPdf(pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
      print(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _query = Firestore.instance
        .collection('Users')
        .document(widget.email)
        .collection("EachPara")
        .document("DocumentDetails")
        .collection("Docs")
        // .where('email', isEqualTo: widget.email ?? "")
        .snapshots();
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context2, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Heradsfsadfo",
              automaticallyImplyLeading: true,
              
              backgroundColor: Theme.of(context2).dividerColor,
              largeTitle: Text(
                'Medical Records',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return CupertinoActivityIndicator();
                } else {
                  print("Lenght is ${snapshot.data.documents.length}");

                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name : ${snapshot.data.documents[i]["Name"]}" ??
                                            "Name",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Updated Date : ${snapshot.data.documents[i]["Date"]}" ??
                                            "Date",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Description : ${snapshot.data.documents[i]["Description"]}" ??
                                            "Description",
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        downloadPdf(snapshot.data.documents[i]
                                            ["DocUrl"]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          radius: 17,
                                          child: Icon(Icons.delete),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "${snapshot.data.documents[i]["DocUrl"]}");
                                        downloadPdf(snapshot.data.documents[i]
                                            ["DocUrl"]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 17,
                                            child: Icon(Icons.download_rounded,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      body: Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: nameOfDoc,
                                    decoration: InputDecoration(
                                      hintText: "Name of the Document",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.amber,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                new Flexible(
                                  child: new TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: desOfDoc,
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.amber,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                new CupertinoButton(
                                  onPressed: () => {
                                    if (nameOfDoc.text != null &&
                                        desOfDoc.text != null)
                                      {
                                        getAndUploadPdf().whenComplete(
                                            () => Navigator.pop(context)),
                                      }
                                  },
                                  color: Colors.green,
                                  borderRadius: new BorderRadius.circular(10.0),
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                new CupertinoButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  color: Colors.red,
                                  borderRadius: new BorderRadius.circular(10.0),
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Icon(Icons.cloud_upload_rounded),
          ),
        ),
      ),
    );
  }

  Future getAndUploadPdf() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //         type: FileType.custom,
    //         allowedExtensions: ['jpg', 'pdf', 'doc'],
    //       );
    File file =
        await FilePicker.getFile(type: FileType.custom, fileExtension: 'pdf');
    String fileName = formattedDate + nameOfDoc.text + '.pdf';
    print("fileName  " + fileName);
    print('${file.readAsBytesSync()}');
    savePdf(file.readAsBytesSync(), fileName);
  }

  Future savePdf(List<int> asset, String name) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child(widget.email).child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    Fire.documentUrlToFireStore(
            url: url,
            email: widget.email,
            date: date2,
            name: nameOfDoc.text,
            description: desOfDoc.text)
        .then((v) => {print("vvvvvvvvv " + v)});
    return url;
  }
// void documentFileUpload(String str) {

//   var data = {
//     "PDF": str,
//   };
//   mainReference.child("Documents").child('pdf').set(data).then((v) {
//   });
// }
}
