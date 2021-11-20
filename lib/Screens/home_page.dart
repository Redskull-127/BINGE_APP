import 'package:flutter/material.dart';
import 'package:movie_app_flutter/assets/meer_icons.dart';
import 'package:share/share.dart';
import 'package:movie_app_flutter/Screens/browser_page.dart';
import 'package:movie_app_flutter/Screens/paste_link_page.dart';
// import 'package:movie_app_flutter/Screens/insta.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentIndex = 0;

  String data = "";

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.landscape
          ? null
          : // show nothing in lanscape mode
          AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
              title: Text(
                "YT Downloader",
                style: TextStyle(color: Colors.red),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Share.share(
                          "Download Youtube Videos for free  https://redskull-127.github.io/BINGE/");
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.red,
                    ))
              ],
            ),
      body: bodyPages(data)[_currentIndex],
      bottomNavigationBar:
          MediaQuery.of(context).orientation == Orientation.landscape
              ? null
              : BottomNavigationBar(
                  currentIndex: _currentIndex,
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.red,
                  items: items,
                  onTap: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                ),
    );
  }

  List<Widget> bodyPages(String data) {
    return <Widget>[
      PasteLinkPage(data: data),
      BrowserPage(data: data),
      // InstaLinkPage(data: data),
    ];
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.download,
          color: Colors.red,
        ),
        label: "DOWNLOAD"),
    BottomNavigationBarItem(
        icon: Icon(MEERIcon.youtube_play, color: Colors.red),
        label: "YT Browser"),
    // BottomNavigationBarItem(
    //     icon: Icon(MEERIcon.youtube_play, color: Colors.red), label: "Insta"),
  ];
}
