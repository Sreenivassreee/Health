import 'package:Health/Views/introScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        customAppWhite(),
        customAppTheme(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ThemeConsumer(
          child: IntroScreen(),
        ),
      ),
    );
  }
}

AppTheme customAppWhite() {
  return AppTheme(
    id: "white",
    description: "Custom Color Scheme",
    data: ThemeData(
        fontFamily: 'arial',
        primarySwatch: Colors.red,
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.indigo[50],
        // cardColor: Colors.grey[850],
//        cardColor: Color(0xFF171332),
        primaryColor: Colors.black,
        accentColor: Colors.red,
        // canvasColor: Colors.grey[50],
        applyElevationOverlayColor: true,
        disabledColor: Colors.grey,
        dividerColor: Colors.white,
        cursorColor: Colors.indigo[50],
        canvasColor: Colors.red

        // appBarTheme: AppBarTheme(
        //   color: Colors.red,

        //   elevation: 0.0,
        // accentColor: Colors.yellow,
        // primaryColor: Colors.red,
        // scaffoldBackgroundColor: Colors.yellow[200],
        // buttonColor: Colors.amber,
        // dialogBackgroundColor: Colors.yellow,
        // ),
        ),
  );
}

AppTheme customAppTheme() {
  return AppTheme(
    id: "pureblack",
    description: "Custom Color Scheme",
    data: ThemeData(
      fontFamily: 'arial',
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      cardColor: Colors.blueGrey[800],
      // cardColor: Colors.grey[850],
//        cardColor: Color(0xFF171332),
      primaryColor: Colors.white,
      bottomAppBarColor: Colors.red,
      scaffoldBackgroundColor: Colors.black,

      accentColor: Colors.red,
      canvasColor: Colors.grey[50],
      applyElevationOverlayColor: true,
      disabledColor: Colors.grey,
      cursorColor: Colors.indigo[50],
      dividerColor: Colors.black,

      // appBarTheme: AppBarTheme(
      //   color: Colors.red,

      //   elevation: 0.0,
      // accentColor: Colors.yellow,
      // primaryColor: Colors.red,
      // scaffoldBackgroundColor: Colors.yellow[200],
      // buttonColor: Colors.amber,
      // dialogBackgroundColor: Colors.yellow,
      // ),
    ),
  );
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   final GoogleSignIn _googleSignIn2 =
//       GoogleSignIn(scopes: ['email', 'profile']);
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<FirebaseUser> _handleSignIn() async {
//     FirebaseUser user;
//     bool isSignedIn = await _googleSignIn2.isSignedIn();
//     if (isSignedIn) {
//       user = await _auth.currentUser();
//       print("displayName" + user.displayName);
//     } else {
//       try {
//         final GoogleSignInAccount googleUser = await _googleSignIn2.signIn();
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final AuthCredential credential = GoogleAuthProvider.getCredential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//         user = (await _auth.signInWithCredential(credential)).user;
//       } catch (e) {
//         // ErrorPage(context: context, message: "Internet Problem");
//         print(e);
//         // logOut(context);
//       }

//       // print(user.gmailId);
//     }

//     return user;
//   }

//   void onGoogleSignIn(BuildContext context) async {
//     FirebaseUser currentUser = await _handleSignIn();

//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => HomeDesign(
//     //         //  user, _googleSignIn
//     //         ),
//     //   ),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               onPressed: _handleSignIn,
//             ),
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: null,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
