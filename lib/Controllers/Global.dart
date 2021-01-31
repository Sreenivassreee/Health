import 'package:Health/Controllers/Preferences.dart';
import 'package:Health/Views/introScreen.dart';
import 'package:Health/models/error.dart';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void FailedCase({context, message}) {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => IntroScreen(),
    ),
  );
  _key.currentState.showSnackBar(SnackBar(
    content: Text(message),
  ));
  return;
}

Future<String> checkNetWork(BuildContext context) async {
  String _mess;
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    _mess = "Pass";
  } else {
    ErrorPage(
      context: context,
      message: "Please Check Internet Connection",
    );
    _mess = "Failed";
  }
  return _mess;
}

// void netWorkError({BuildContext context, String message}) {
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//       builder: (BuildContext context) => ErrorPage(message: message),
//     ),
//   );
// }

final scaffoldKey = GlobalKey<ScaffoldState>();

void snake({String message = "Something Wrong", BuildContext context}) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 5),
    content: Text(
      message,
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
  );
  scaffoldKey.currentState.showSnackBar(snackBar);
}

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

Future<void> logOut(BuildContext context) async {
  await _googleSignIn.signOut();
  try {
    Pref.signOutPref().then(
      (value) {
        print("Value is $value");
        if (value == "Sucess") {
          Pref.saveLoginStatusPrifFalse().then((value) {
            if (value == "Sucess") {
              // ErrorPage(context: context);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (contaxt) => IntroScreen(),
                ),
                (route) => false,
              );
            }
          });
        }
      },
    );
  } catch (err) {
    // ErrorPage(context: context, message: err);
    Pref.saveLoginStatusPrifFalse();

    print(err);
  }

// }
//  ThemeData(
//               fontFamily: 'arial',
//               brightness: Brightness.dark,
//               primarySwatch: Colors.red,
//               cardColor: Colors.blueGrey[800],
//               // cardColor: Colors.grey[850],
// //        cardColor: Color(0xFF171332),
//               primaryColor: Colors.black,
//               scaffoldBackgroundColor: Colors.black,
//               accentColor: Colors.red,
//               canvasColor: Colors.grey[50],
//               disabledColor: Colors.grey,
//               appBarTheme: AppBarTheme(
//                 elevation: 0.0,

// MaterialApp(
//   color: Colors.black,
//   debugShowCheckedModeBanner: false,
//   title: 'Math Quiz',
// //       theme:
//      ThemeData(
//         fontFamily: 'arial',
//         brightness: Brightness.dark,
//         primarySwatch: Colors.red,
//         cardColor: Colors.blueGrey[800],
//         // cardColor: Colors.grey[850],
// //        cardColor: Color(0xFF171332),
//         primaryColor: Colors.black,
//         scaffoldBackgroundColor: Colors.black,
//         accentColor: Colors.red,
//         canvasColor: Colors.grey[50],
//         disabledColor: Colors.grey,
//         appBarTheme: AppBarTheme(
//           elevation: 0.0,
//         ),
//   ),
// ),
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

loading({mess = "Loading...", time = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
    msg: mess,
    toastLength: time == "short" ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

// dialog({String addedCoins = "0", context, url}) {
//   showDialog(
//     context: context,
//     builder: (_) => NetworkGiffyDialog(
//       // key: Net,
//       image: CachedNetworkImage(
//         imageUrl: url,
//         // "https://media.giphy.com/media/MkvZFvzHIWbRK/giphy.gif",
//         fit: BoxFit.cover,
//         placeholder: (context, url) => Center(
//           child: CupertinoActivityIndicator(),
//         ),
//       ),
//       entryAnimation: EntryAnimation.TOP,
//       title: Text(
//         '+ $addedCoins',
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w600),
//       ),

//       description: Text(
//         'Watch More Earn More',
//         style: TextStyle(
//           fontSize: 22,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       onlyOkButton: true,
//       onOkButtonPressed: () {
//         Navigator.of(context).pop();
//       },
//     ),
//   );
// }
