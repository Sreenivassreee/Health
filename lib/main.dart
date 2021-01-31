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
        primaryColor: Colors.black,
        accentColor: Colors.red,
        applyElevationOverlayColor: true,
        disabledColor: Colors.grey,
        dividerColor: Colors.white,
        cursorColor: Colors.indigo[50],
        canvasColor: Colors.red),
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
      primaryColor: Colors.white,
      bottomAppBarColor: Colors.red,
      scaffoldBackgroundColor: Colors.black,
      accentColor: Colors.red,
      canvasColor: Colors.grey[50],
      applyElevationOverlayColor: true,
      disabledColor: Colors.grey,
      cursorColor: Colors.indigo[50],
      dividerColor: Colors.black,
    ),
  );
}
