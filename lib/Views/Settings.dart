import 'package:Health/Services/Global.dart';
import 'package:Health/Views/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var WhatsAppNofi = false;
  var SMSNofi = false;
  var MailNofi = false;
  var photoUrl;
  // void initState() async {
  //   // data();

  //   super.initState();
  //   // geturl();
  //   //1
  // }
  @override
  void initState() {
    super.initState();
    geturl();
  }

  geturl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      photoUrl = preferences.getString("photoUrl");
    });
    print("photoUrl");

    print(photoUrl);
  }

  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );

  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );

  // _launchURL(url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
                heroTag: "Hero0",
                largeTitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "arial",
                    ),
                  ),
                ),
              )
            ];
          },
          body: Scaffold(
            body: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ThemeConsumer(
                              child: Profile(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Theme.of(context).dividerColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        photoUrl ??
                                            //   widget.MainData["MainPhotoUrl"] == null
                                            // ?
                                            "https://www.pngitem.com/pimgs/m/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png"
                                        //       : widget.MainData["MainPhotoUrl"],
                                        ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     MainData["About"],
                    //     style: TextStyle(
                    //       color: Colors.grey.shade400,
                    //     ),
                    //   ),
                    // ),
                    Card(
                      child: Container(
                        child: MergeSemantics(
                          child: ListTile(
                            title: Text('WhatsApp Notifications'),
                            trailing: CupertinoSwitch(
                              value: WhatsAppNofi,
                              onChanged: (bool value) {
                                setState(() {
                                  WhatsAppNofi = value;
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                WhatsAppNofi = !WhatsAppNofi;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        child: MergeSemantics(
                          child: ListTile(
                            title: Text('SMS Notifications'),
                            trailing: CupertinoSwitch(
                              value: SMSNofi,
                              onChanged: (bool value) {
                                setState(() {
                                  SMSNofi = value;
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                SMSNofi = !SMSNofi;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        child: MergeSemantics(
                          child: ListTile(
                            title: Text('Mail Notifications'),
                            trailing: CupertinoSwitch(
                              value: MailNofi,
                              onChanged: (bool value) {
                                setState(() {
                                  MailNofi = value;
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                MailNofi = !MailNofi;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Change Theme   ( Dark / Light )",
                        ),
                        // focusColor: Colors.red,
                        // subtitle: Text(
                        //   "English US",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          ThemeProvider.controllerOf(context).nextTheme();
                        },
                      ),
                    ),
                    // Card(
                    //   elevation: 0,
                    //   color: Theme.of(context).dividerColor,
                    //   child: ListTile(
                    //     title: Text(
                    //       "White Theme",
                    //     ),
                    //     focusColor: Colors.red,
                    //     // subtitle: Text(
                    //     //   "English US",
                    //     //   style: greyTExt,
                    //     // ),
                    //     trailing: Icon(
                    //       Icons.keyboard_arrow_right,
                    //       color: Colors.grey.shade400,
                    //     ),
                    //     onTap: () {
                    //       ThemeProvider.controllerOf(context).setTheme("white");

                    //       // ThemeProvider.controllerOf(context).setTheme(pureblack);

                    //       // changeBrightness(context);
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),

                    Card(
                      color: Theme.of(context).dividerColor,
                      elevation: 0,
                      child: ListTile(
                        title: Text("Logout"),
                        onTap: () async {
                          await logOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
