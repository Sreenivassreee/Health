// import 'package:google_sign_in/google_sign_in.dart';

import 'dart:ui';

import 'package:Health/Services/Firebase.dart';
import 'package:Health/Services/Global.dart';
import 'package:Health/Services/Preferences.dart';
import 'package:Health/Views/FadeAnimation.dart';
import 'package:Health/Views/HomeDesign.dart';
import 'package:Health/models/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleWithLogin extends StatefulWidget {
  @override
  _GoogleWithLoginState createState() => _GoogleWithLoginState();
}

class _GoogleWithLoginState extends State<GoogleWithLogin> {
  bool _isLoggedIn = false;
  TextEditingController emplyEmailId = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool isLoading = false;
  bool netStatus;
  bool createOne = false;
  bool alreadyHaveAccount = false;
  String accountStatus = " ";
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  final GoogleSignIn _googleSignIn2 =
      GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences preferences;

  @override
  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser user;

    bool isSignedIn = await _googleSignIn2.isSignedIn();
    if (isSignedIn) {
      user = await _auth.currentUser();
      print("Before displayName" + user.displayName);
    } else {
      try {
        final GoogleSignInAccount googleUser = await _googleSignIn2.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        user = (await _auth.signInWithCredential(credential)).user;
        print("After displayName" + user.displayName);
        Pref.saveLoginStatusPrif();
        preferences = await SharedPreferences.getInstance();
        preferences.setString("email", user.email);
      } catch (e) {
        // ErrorPage(context: context, message: "Internet Problem");
        print(e);
        logOut(context);
      }
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser currentUser = await _handleSignIn();

    await Fire.UpDateDetails(
            user: currentUser,
            phoneNumber: phoneNumber.text,
            age: age.text,
            email: emplyEmailId.text,
            context: context)
        .then((v) => {
              if (v == "invalid")
                {
                  logOut(context)
                      .whenComplete(() => ErrorPage(context: context))
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeDesign(currentUser.email
                          //  user, _googleSignIn
                          ),
                    ),
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400]
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "TCS ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'arial',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'arial',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 50,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emplyEmailId,
                                          decoration: InputDecoration(
                                            hintText: "Employ EmailID",
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
                                    ],
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () async {
                                    await Fire.fireBaseUserData(
                                            email: emplyEmailId.text,
                                            context: context)
                                        .then((v) => {
                                              if (v == null)
                                                {
                                                  setState(() {
                                                    createOne = true;
                                                    alreadyHaveAccount = true;
                                                    accountStatus =
                                                        "No account found with this email. \n Create one for you ..!!";
                                                  }),
                                                }
                                              else
                                                {
                                                  setState(() {
                                                    accountStatus =
                                                        "Account Already Exist \n please use same email to login";
                                                  }),
                                                }
                                            });
                                    // if (emplyEmailId.text != null) {}
                                  },
                                  // subtractNumbers,
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    "Submit",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10),
                                  child: Text(
                                    accountStatus ?? "",
                                    style: TextStyle(
                                        color: accountStatus[0] == "N"
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ),
                                createOne == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: age,
                                                decoration: InputDecoration(
                                                  hintText: "Age",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                      color: Colors.amber,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                createOne == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.0, right: 15.0, top: 10),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: phoneNumber,
                                                decoration: InputDecoration(
                                                  hintText: "Phone Number",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                      color: Colors.amber,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            // SizedBox(
                            //   height: 30,
                            //
                            // ),
                            FadeAnimation(
                              1.4,
                              Stack(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(vertical: 10),
                                  //   child: Container(
                                  //     height:
                                  //         MediaQuery.of(context).size.height /
                                  //             20,
                                  //     margin:
                                  //         EdgeInsets.symmetric(horizontal: 30),
                                  //     // child: SvgPicture.asset(
                                  //     //   "assets/images/signup.svg",
                                  //     //   height: 500,
                                  //     //   width: 500,
                                  //     // ),
                                  //   ),
                                  // ),
                                  _isLoggedIn
                                      ? Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Center(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 6,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FadeAnimation(
                              2.5,
                              Container(
                                height: 55,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange[900]),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FlatButton.icon(
                                      icon: Icon(FontAwesomeIcons.google,
                                          color: Colors.white),
                                      onPressed: () async {
                                        setState(() {
                                          _isLoggedIn = true;
                                        });
                                        onGoogleSignIn(context);
                                        // checkNetWork(context).then(
                                        //   (value) {
                                        //     print("NetworkValue is $value");
                                        //     if (value == "Pass") {
                                        //       onGoogleSignIn(context);
                                        //       // _login();
                                        //       setState(
                                        //         () {
                                        //           // _isLoggedIn == true;
                                        //         },
                                        //       );
                                        //     }
                                        //   },
                                        // );
                                      },
                                      label: Expanded(
                                        child: Text(
                                          'LOGIN WITH GOOGLE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: _isLoggedIn == false
//           ? Center(
//               child: Container(
//                 padding: EdgeInsets.all(30),
//                 decoration: BoxDecoration(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FlutterLogo(
//                       size: 150,
//                     ),
//                     Text(
//                       'Login to Start',
//                       textAlign: TextAlign.center,
//                     ),
//                     FlatButton(
//                       color: Colors.red,
//                       child: Icon(Icons.person),
    // onPressed: () {
    // checkNetWork(context).then(
    //   (value) {
    //     print("NetworkValue is $value");
    //     if (value == "Pass") {
    //       _login();
    //       setState(
    //         () {
    //           _isLoggedIn == true;
    //         },
    //       );
    //     }
    //   },
    // );
//                       },
//                     ),
// //              LoginButton(
// //                text: 'LOGIN WITH GOOGLE',
// //                icon: FontAwesomeIcons.google,
// //                color: Colors.black45,
// //                loginMethod: () => _login(),
// //              ),
//                     //  LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
//                   ],
//                 ),
//               ),
// //                    LoginButton(), // <-- Built with StreamBuilder
// //                    UserProfile() // <-- Built with StatefulWidget
//             )
//           : Container(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                         height: 70,
//                         width: 70,
//                         child: CupertinoActivityIndicator(
//                           radius: 40.0,
//                         )),
//                   ),
//                   Text(
//                     "Setting Up For You...",
//                     style: TextStyle(color: Colors.green, fontSize: 20.0),
//                   ),
//                   Text(
//                     "Plese Wait Dont Quit",
//                     style: TextStyle(color: Colors.green, fontSize: 15.0),
//                   )
//                 ],
//               ),
//             ),
//     );
  }
}
