import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  String email;
  // final currentScore, currentLevel;
  DashBoard(this.email);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    String mail = "";
    SharedPreferences preferences;
    abc() async {
      preferences = await SharedPreferences.getInstance();
      mail = preferences.getString("email");
      print("mail  " + mail);
      print("hhhhhhhhhhhhhhhhhhhhh");
    }

    @override
    void initState() async {
      super.initState();
      // abc();
    }

    Stream<QuerySnapshot> _query = Firestore.instance
        .collection('Users')
        .document(widget.email)
        .collection("EachPara")
        // .where('email', isEqualTo: widget.email ?? "")
        .snapshots();

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context2, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Hero",
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context2).dividerColor,
              largeTitle: Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: StreamBuilder<QuerySnapshot>(
          stream: _query,
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator();
            } else {
              print("Lenght is ${snapshot.data.documents.length}");
              // print(
              // "Lenght is ${snapshot.data.documents[0]['EachPara']['sugar']}");

              var bp = double.parse(
                          snapshot.data.documents[0]['EachPara'].last['bp']) /
                      200 -
                  0.25;
              var sugar = double.parse(snapshot
                          .data.documents[0]['EachPara'].last['sugar']) /
                      200 -
                  0.25;
              print(bp);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: bp,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: sugar,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 110.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: bp,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 140.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: bp,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 170.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: bp,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 200.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: bp,
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 2300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.green,
                                          height: 10,
                                          width: 20,
                                        ),
                                      ),
                                      Text("Safe"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.red,
                                          height: 10,
                                          width: 20,
                                        ),
                                      ),
                                      Text("Danger"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
