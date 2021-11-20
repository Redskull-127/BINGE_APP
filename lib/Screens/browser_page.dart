import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:movie_app_flutter/Screens/home_page.dart';
import '../downloader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BrowserPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: must_be_immutable
class BrowserPage extends StatefulWidget {
  String data;
  BrowserPage({this.data});
  @override
  _BrowserPageState createState() => _BrowserPageState();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // textTheme: GoogleFonts.latoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          fontFamily: 'Raleway'),
    );
  }
}

class _BrowserPageState extends State<BrowserPage> {
  final link = "https://www.youtube.com";
  WebViewController _controller;

  bool _showDownloadButton = false;

  void checkUrl() async {
    if (await _controller.currentUrl() == "https://m.youtube.com/") {
      setState(() {
        _showDownloadButton = false;
      });
    } else {
      setState(() {
        _showDownloadButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUrl();

    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
        }
        return false;
      },
      child: Scaffold(
        body: WebView(
          initialUrl: widget.data == "" ? link : widget.data,
          javascriptMode: JavascriptMode.unrestricted,
          onWebResourceError: (error) {
            showDialog(
                context: context,
                barrierColor: Colors.grey,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Something went wrong!"),
                    content: Text("Missing Internet connection"),
                    scrollable: true,
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                                (route) => false);
                          },
                          child: Text("Okay"))
                    ],
                  );
                });
          },
          onWebViewCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
        ),
        floatingActionButton: _showDownloadButton == false
            ? Container()
            : FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () async {
                  final url = await _controller.currentUrl();
                  final title = await _controller.getTitle();

                  ///Download the video
                  Download().downloadVideo(url, "$title");
                },
                child: Icon(Icons.download),
              ),
      ),
    );
  }
}
