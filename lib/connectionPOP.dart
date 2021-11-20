import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:restart_app/restart_app.dart';
import 'main.dart';

void connectionPOP() {
  runApp(
    MaterialApp(
      home: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/noconn.png',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "RESTART",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.all(10),
                ),
              ),
            ]),
      ),
    ),
  );
}
// Restart.restartApp(webOrigin: '[MyApp()]');