import 'dart:io';
import 'package:Health/Services/Firebase.dart';
import 'package:Health/Services/Global.dart';
import 'package:Health/Services/Preferences.dart';
import 'package:Health/Views/GoogleWithLogin.dart';
import 'package:Health/Views/HomeDesign.dart';
import 'package:Health/models/error.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_provider/theme_provider.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String id;
  bool net = true;
  @override
  void initState() {
    super.setState(() {});
    abc();
    checkNetWork();
  }

  void abc() {
    Future.delayed(Duration(milliseconds: 1000), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ThemeConsumer(
            child: GoogleWithLogin(),
          ),
        ),
      );
    });
  }

  checkNetWork() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isLogin = preferences.getString("ISLOGIN");
    var email = preferences.getString("email");
    // print(isLogin);
    // print(id);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (isLogin == "TRUE") {
        // print("id is $id");
        if (email != null) {
          sleep(const Duration(microseconds: 2000));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ThemeConsumer(
                child: HomeDesign(email),
              ),
            ),
          );

          // ErrorPage(context: context, message: "Try Again");

          // if (value == "Succes") {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (BuildContext context) => ThemeConsumer(
          //         child: HomeDesign(),
          //       ),
          //     ),
          //   );
        } else {
          logOut(context);
        }
      } else {
        sleep(const Duration(microseconds: 1000));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ThemeConsumer(
              child: GoogleWithLogin(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        net = false;
      });
      Fluttertoast.showToast(
        msg: "Not Connected to internet ! \n Try Agin",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      sleep(Duration(microseconds: 1000));

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ThemeConsumer(
      //       child: Intro(),
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                color: Colors.yellowAccent,
                child: Center(
                  child: Container(
                    child: Text("TATA HelthCare"),
                  ),
                ),
              ),

              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              // child: Image.asset(
              //   "assets/images/intro2.jpg",
              //   fit: BoxFit.cover,
              // ),

              Align(
                alignment: Alignment.bottomCenter,
                child: net == true
                    ? Container(
                        margin: EdgeInsets.only(bottom: 55),
                        child: CupertinoActivityIndicator(
                          radius: 12,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Image.asset(
                      "assets/images/steve.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
