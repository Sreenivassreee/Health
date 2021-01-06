import 'package:flutter/material.dart';


class ErrorPage {
  BuildContext context;

  String message;

  ErrorPage({this.message, this.context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.red,
                size: 90.0,
              ),
              Flexible(
                child: Text(
                  "Error",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  message ?? "Somthing Went Wrong try Again",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      9.0,
                    ),
                  ),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (contaxt) => Intro(),
                  //   ),
                  //   (route) => false,
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
