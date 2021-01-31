import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:theme_provider/theme_provider.dart';

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = "0";
  StreamSubscription<int> _subscription;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  double _numerox; //numero pasos
  double _convert;
  double _kmx;
  double burnedx;
  double per;
  int editStepsText = 50000;
  TextEditingController editSteps = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    _onData(event.steps);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {});
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {});
  }

  void onStepCountError(error) {}

  void _onData(int stepCountValue) async {
    setState(() {
      _stepCountValue = "$stepCountValue";
    });

    var dist = stepCountValue;
    double y = (dist + .0);

    setState(() {
      _numerox = y;
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    setState(() {
      _km = "$distance";
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  void getBurnedRun() {
    setState(() {
      var calories = _kmx;
      _calories = "$calories";
    });
  }

  @override
  Widget build(BuildContext context) {
    per = (int.parse(_stepCountValue) / editStepsText);
    getBurnedRun();
    return ThemeConsumer(
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                automaticallyImplyTitle: true,
                automaticallyImplyLeading: true,
                actionsForegroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).dividerColor,
                heroTag: "asdf",
                largeTitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Workout',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "arial",
                    ),
                  ),
                ),
              )
            ];
          },
          body: new Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: new CircularPercentIndicator(
                    radius: 170.0,
                    lineWidth: 13.0,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                    percent: per,

                    center: Container(
                      //color: Colors.orange,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_stepCountValue',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
                            '/ ${editStepsText}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                      // height: 50.0,
                      // width: 50.0,
                    ),
                    //percent: _convert,
                    footer: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(
                              "Daily Goales:  $editStepsText Steps",
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Scaffold(
                                          body: Dialog(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    new Flexible(
                                                      child: new TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        controller: editSteps,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter no of steps",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.amber,
                                                              style: BorderStyle
                                                                  .solid,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    new CupertinoButton(
                                                      onPressed: () => {
                                                        if (editSteps.text !=
                                                            null)
                                                          {
                                                            setState(() {
                                                              editStepsText =
                                                                  int.parse(
                                                                      editSteps
                                                                          .text);
                                                            })
                                                          },
                                                        editSteps.text = "",
                                                        Navigator.pop(context),
                                                      },
                                                      color: Colors.green,
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                      child: Text(
                                                        "Submit",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    new CupertinoButton(
                                                      onPressed: () => {
                                                        Navigator.pop(context)
                                                      },
                                                      color: Colors.red,
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                      child: Text(
                                                        "Cancel",
                                                        textAlign:
                                                            TextAlign.center,
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
                                child: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.walking,
                      size: 40,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    new Text(
                      "${((int.parse(_stepCountValue) / editStepsText) * 100).toStringAsFixed(2)} %",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "ToDay Completed",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "$_km",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Kms",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "$_calories",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Cal",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "$_stepCountValue",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Steps",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // new Container(
                      //   padding: EdgeInsets.only(left: 10.0),
                      //   child: new Card(
                      //     child: Container(
                      //       child: Text(
                      //         "$_calories kCal",
                      //         textAlign: TextAlign.right,
                      //         style: new TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 14.0,
                      //             color: Colors.white),
                      //       ),
                      //     ),
                      //     color: Colors.red,
                      //   ),
                      // ),
                      //     VerticalDivider(
                      //       width: 20.0,
                      //     ),
                      //     new Container(
                      //       padding: EdgeInsets.only(left: 10.0),
                      //       child: new Card(
                      //         child: Container(
                      //           child: Text(
                      //             "$_stepCountValue Steps",
                      //             textAlign: TextAlign.right,
                      //             style: new TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 14.0,
                      //                 color: Colors.white),
                      //           ),
                      //         ),
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(
                      //   height: 10,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
                      //   color: Colors.black12,
                      //   child: Row(
                      //     children: <Widget>[
                      //       new Container(
                      //         child: new Card(
                      //           child: Container(
                      //             height: 80.0,
                      //             width: 80.0,
                      //           ),
                      //           color: Colors.white54,
                      //         ),
                      //       ),
                      //       VerticalDivider(
                      //         width: 20.0,
                      //       ),
                      //       new Container(
                      //         child: new Card(
                      //           child: Container(
                      //             height: 80.0,
                      //             width: 80.0,
                      //           ),
                      //           color: Colors.transparent,
                      //         ),
                      //       ),
                      //       VerticalDivider(
                      //         width: 20.0,
                      //       ),
                      //       new Container(
                      //         child: new Card(
                      //           child: Container(
                      //             height: 80.0,
                      //             width: 80.0,
                      //           ),
                      //           color: Colors.transparent,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Divider(
                      //   height: 10,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(top: 2.0),
                      //   width: 200, //ancho
                      //   height: 100, //l
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
