import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  String email;
  // final currentScore, currentLevel;
  Diseases(this.email);
  @override
  _DiseasesState createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _query = Firestore.instance
        .collection('Users')
        .document(widget.email)
        .collection("EachPara")
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _query,
        builder: (BuildContext context, snap) {
          if (snap.data.documents[3]['CHD'] == null) {
            return Center(
              child: Text(
                "No Data",
              ),
            );
          } else {
            print("Lenght is ${snap.data.documents.length}");
            print(snap.data);
            var chd =
                snap.data.documents[3]['CHD'] == true ? "Danger" : "Normal";

            var asthama =
                snap.data.documents[3]['asthma'] == true ? "Danger" : "Normal";

            var hypoxemia = snap.data.documents[3]['hypoxemia'] == true
                ? "Danger"
                : "Normal";

            var diabetes = snap.data.documents[3]['diabetes'] == true
                ? "Danger"
                : "Normal";
            print(chd);
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Diseases ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Diabetes"),
                              Text(
                                "$diabetes",
                                style: TextStyle(
                                    color: diabetes == "Danger"
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Coronary heart disease"),
                              Text(
                                "$chd",
                                style: TextStyle(
                                    color: chd == "Danger"
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hypoxemia"),
                              Text(
                                "$hypoxemia",
                                style: TextStyle(
                                  color: hypoxemia == "Danger"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Asthama"),
                              Text(
                                "$asthama",
                                style: TextStyle(
                                    color: asthama == "Danger"
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
