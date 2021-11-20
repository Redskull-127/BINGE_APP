import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/unityad.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ad.dart';

class Description extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String name, description, bannerurl, posterurl, vote, launch_on, url;

  const Description(
      {Key key,
      this.name,
      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.url,
      // ignore: non_constant_identifier_names
      this.launch_on})
      : super(key: key);

  _launchURL() async {
    var ul = 'https://google.com/search?q=' + this.url;
    if (await canLaunch(ul)) {
      await launch(ul);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: modified_text(text: '⭐ Average Rating - ' + vote)),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: name != null ? name : 'Not Loaded', size: 24)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child:
                  modified_text(text: 'Releasing On - ' + launch_on, size: 14)),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: description, size: 18)),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.yoku.marumovie',
                  openStore: false,
                );
              },
              child: Text('OPEN - CINEMA HD V2'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              )),
          ElevatedButton(
              onPressed: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.cybermedia.cyberflx',
                  openStore: false,
                );
              },
              child: Text('OPEN - CYBERFLIX TV'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              )),
          ElevatedButton(
              onPressed: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.codehardy.momix',
                  openStore: false,
                );
              },
              child: Text('OPEN - MO MIX'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              )),
          ElevatedButton(
              onPressed: _launchURL,
              child: Text('MORE'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              )),
          HomeScreen(),
        ]),
      ),
    );
  }
}
