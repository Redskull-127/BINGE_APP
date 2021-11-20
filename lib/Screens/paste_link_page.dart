import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:movie_app_flutter/downloader.dart';
import 'package:movie_app_flutter/ad.dart';

import '../unityad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasteLinkPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: must_be_immutable
class PasteLinkPage extends StatefulWidget {
  String data;
  PasteLinkPage({this.data});
  @override
  _PasteLinkPageState createState() => _PasteLinkPageState();
}

class _PasteLinkPageState extends State<PasteLinkPage> {
  TextEditingController _textController = TextEditingController();

  VideoPlayerController controller;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _textController.text = widget.data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ///Text Form field for pasting the link

            TextFormField(
              controller: _textController,
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(
                labelText: "Paste Youtube Video Link Here ...",
                fillColor: Colors.grey,
                filled: true,
              ),
            ),

            ///Download Button for extrating and downloading the link
            GestureDetector(
              onTap: () {
                if (_textController.text.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("No link pasted")));
                } else {
                  ///Download the video
                  Download().downloadVideo(
                      _textController.text.trim(), "Youtube Downloader");
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  color: Colors.red,
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.download,
                    size: 20,
                  )),
            ),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
