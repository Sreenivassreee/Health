import 'package:Health/Controllers/Firebase.dart';
import 'package:Health/Controllers/Preferences.dart';
import 'package:Health/models/PrefData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  // Map ProfileData;
  // Profile({this.ProfileData});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

  TextEditingController age = TextEditingController();

  String photoUrl;

  final FocusNode myFocusNode = FocusNode();

  final _s = GlobalKey<ScaffoldState>();

  prefMainModel mainProfile = prefMainModel();

  @override
  void initState() {
    Pref.getMainPref();

    Pref.getMainPref().then((value) {
      mainProfile = value;
      setState(() {
        email.text = mainProfile.mainEmail;
        photoUrl = mainProfile.mainPhotoUrl;
        name.text = mainProfile.mainName;
        mobile.text = mainProfile.mainMobile;
        age.text = mainProfile.mainAge;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _s,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "arial",
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              photoUrl != null ? photoUrl : "shorturl.at/ruIU6",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: new Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'About',
                                            style: TextStyle(
                                                fontSize: 28.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            "Name",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: name,
                                            decoration: InputDecoration(
                                              hintText: name.text,
                                              enabled: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: email,
                                          decoration: InputDecoration(
                                            hintText: email.text,
                                            enabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: mobile,
                                          decoration: InputDecoration(
                                            hintText: mobile.text,
                                            enabled: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Age',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: age,
                                          decoration: InputDecoration(
                                            hintText: age.text,
                                            enabled: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _getActionButtons()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 16.0),
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50.0,
          width: double.infinity,
          child: new RaisedButton(
            child: new Text("Update"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              Fire.updateProfile(
                email: mainProfile.mainEmail,
                name: name.text,
                mobile: mobile.text,
                age: age.text,
              ).then((value) {
                if (value == "Sucess") {
                  Pref.updateProfilePref(
                    name: name.text,
                    mobile: mobile.text,
                    age: age.text,
                  ).then((_value2) {
                    if (_value2 == "Sucess") {
                      print("Updated");
                      final snackBar = SnackBar(
                        content: Text('Updated'),
                      );
                      _s.currentState.showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text('Something went Wrong.. Try Again'),
                      );

                      _s.currentState.showSnackBar(snackBar);
                    }
                  });
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'Something went Wrong.. Try Again',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );

                  _s.currentState.showSnackBar(snackBar);
                }
              });
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
