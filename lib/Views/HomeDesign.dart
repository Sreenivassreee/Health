import 'package:Health/Views/Dash_Board.dart';
import 'package:Health/Views/Settings.dart';
import 'package:Health/Views/StepCounter.dart';
import 'package:Health/Views/Upload_Pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:theme_provider/theme_provider.dart';

import 'package:flutter/services.dart';

//GetPrefData gData = GetPrefData();

class HomeDesign extends StatefulWidget {
  // final VoidCallback signOut;
  var data;
  String email, photoUrl;

  // final currentScore, currentLevel;
  HomeDesign(
    this.email,
    this.photoUrl,
  );
  @override
  HomeDesignState createState() => HomeDesignState();
}

// SingleTickerProviderStateMixin is used for animation
class HomeDesignState extends State<HomeDesign>
// with SingleTickerProviderStateMixin
{
  // String pId;
  // Data da = Data();
  // HomeDesignState({this.pId});

  // The app's "state".

  // Create a tab controller
  TabController controller;
  String MainName, MainMobile, MainEmail, MainPId, _id;
  String MainCurrentLevel, MainCurrentScore, MainPhotoUrl;
  Map<String, String> MainData = {};
  List abc;
  PageController _myPage;

  final _key = new GlobalKey<FormState>();
//  @override
//  bool get wantKeepAlive => true;
// bool isLoading=true;

  int _counter = 0;
  // var db = Mysql();
  var mail = '';
  var col = 0;

  @override
  void initState() {
//    data();
    // _getCustomer();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // getPref();
    _myPage = PageController(initialPage: 0);

    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setEnabledSystemUIOverlays([]);

    // fetchData();
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
//    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // //   if(data != null){
    // //   setState(() {
    // //   isLoading = false;
    //   print(data);
    // //   });
    // // }
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return ThemeConsumer(
      child: Scaffold(
        key: _key,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey[900],
          // color: const Color(0xFF6739b7),

          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.only(bottom: 5.0),

//          color: Colors.black,

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.home_filled),
                  color: col == 0 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(0);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  icon: Icon(Icons.directions_run_rounded),
                  color: col == 1 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(1);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  icon: Icon(CupertinoIcons.doc_append),
                  color: col == 2 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(2);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(CupertinoIcons.settings_solid),
                  color: col == 3 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(3);
                    });
                  },
                )
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,

          scrollDirection: Axis.horizontal,
          onPageChanged: (int) {
            setState(() {
              col = int;
            });
            // print("int is $int");
            // print(col);
          },

          children: <Widget>[
            Center(
                // getPref(),

                child: DashBoard(widget.email, widget.photoUrl)
                //  DashBoard(
                //   pId: mainPref.MainPId,
                //   currentLevel: mainPref.MainCurrentLevel,
                //   currentScore: mainPref.MainCurrentScore,
                // ),
                ),
            ThemeConsumer(
              child: Center(
                child: Container(child: StepCounter()),
              ),
            ),
            Center(
              child: Container(
                child: UploadPdf(widget.email),
              ),
            ),
            Center(
              child: Container(child: Settings()),
            )
          ],
          // physics:
          //     NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
//         floatingActionButton: Container(
//           height: 65.0,
//           width: 65.0,
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: FittedBox(
//               child: FloatingActionButton(
// //              backgroundColor: Colors.red,
//                   onPressed: () {
//                     // Dia(
//                     //   context: context,
//                     // );

//                     // Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (BuildContext context) => ThemeConsumer(
//                     //       child: HomePage(
//                     //         pId: mainPref.MainPId,
//                     //         compliteLevel: mainPref.MainCurrentLevel,
//                     //         currentScore: mainPref.MainCurrentScore,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // );
//                   },
//                   child: Text(
//                     "Start",
//                     textAlign: TextAlign.center,
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
//                   )
// //              Text(
// //              "Let's Go",
// //              style: TextStyle(fontSize: 11.0),
// //            )
// //              Icon(
// //                Icons.play_arrow,
// ////                color: Colors.white,
// //              ),
//                   // elevation: 5.0,
//                   ),
//             ),
//           ),
//         ),
      ),
    );
  }
}
