import 'dart:convert';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';

import '../unityad.dart';

class MovieDetails extends StatefulWidget {
  final Response data;
  MovieDetails({this.data});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.6, 2),
      end: const Offset(0.1, 2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataM = widget.data.body;
    // ignore: non_constant_identifier_names
    var Genre = [];
    Genre = jsonDecode(dataM)['Genre'].split(", ");

    // ignore: non_constant_identifier_names
    var Actors = [];
    Actors = jsonDecode(dataM)['Actors'].split(", ");

    var ms = jsonDecode(dataM)["Metascore"];
    Color getColor() {
      if (ms == 'N/A') {
        return Colors.lightBlue;
      } else {
        var v = double.parse(ms);
        if (v > 69) {
          return Color(0xFF66CC33);
        } else if (v > 39) {
          return Color(0xFFFFCC33);
        } else {
          return Color(0xFFFF0000);
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: 850,
          ),
          Positioned.fill(
            top: -870,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: 'photo',
                    child: ClipRRect(
                      child: Image.network(
                        jsonDecode(dataM)['Poster'],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0x33000000),
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
              )),
//          Positioned(
//            left: 35,
//            top: 220,
//            child: Container(
//              decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black12,
//                      blurRadius: 20.0,
//                      spreadRadius: 5.0,
//                      offset: Offset(10.0, 10.0),
//                    ),
//                  ],
//                  color: Color(0xFFF7F7F7),
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(40),
//                      bottomLeft: Radius.circular(40))),
//              width: MediaQuery.of(context).size.width,
//              height: 100,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.star,
//                        color: Colors.amber,
//                        size: 35,
//                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.baseline,
//                        textBaseline: TextBaseline.alphabetic,
//                        children: <Widget>[
//                          Text(jsonDecode(dataM)["imdbRating"],
//                              style:
//                                  TextStyle(fontFamily: 'Rubik', fontSize: 19)),
//                          Text(
//                            '/10',
//                            style: TextStyle(fontFamily: 'Rubik'),
//                          )
//                        ],
//                      ),
//                      SizedBox(
//                        height: 1.0,
//                      ),
//                      Text(
//                        jsonDecode(dataM)["imdbVotes"],
//                        style: TextStyle(color: Colors.grey[500]),
//                      )
//                    ],
//                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image.asset(
//                        'assets/rt.png',
//                        width: 33,
//                      ),
//                      Text(jsonDecode(dataM)["Ratings"].length > 1 ? jsonDecode(dataM)["Ratings"][1]['Value']: 'N/A',
//                          style: TextStyle(fontFamily: 'Rubik', fontSize: 17)),
//                      Text(
//                        'RT',
//                        style: TextStyle(
//                            color: Colors.grey[500], fontFamily: 'Rubik'),
//                      )
//                    ],
//                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Container(
//                        width: 40,
//                        height: 30,
//                        color: getColor(),
//                        child: Center(
//                            child: Text(
//                          "$ms",
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 17,
//                              fontFamily: 'Rubik'),
//                        )),
//                      ),
//                      SizedBox(
//                        height: 10.0,
//                      ),
//                      Text(
//                        'Metascore',
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 16,
//                            fontFamily: 'Rubik'),
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      spreadRadius: 5.0,
                      offset: Offset(10.0, 10.0),
                    ),
                  ],
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 35,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(jsonDecode(dataM)["imdbRating"],
                              style:
                                  TextStyle(fontFamily: 'Rubik', fontSize: 19)),
                          Text(
                            '/10',
                            style: TextStyle(fontFamily: 'Rubik'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        jsonDecode(dataM)["imdbVotes"],
                        style: TextStyle(color: Colors.grey[500]),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          jsonDecode(dataM)["Ratings"].length > 1
                              ? jsonDecode(dataM)["Ratings"][1]['Value']
                              : 'N/A',
                          style: TextStyle(fontFamily: 'Rubik', fontSize: 17)),
                      Text(
                        'RT',
                        style: TextStyle(
                            color: Colors.grey[500], fontFamily: 'Rubik'),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 30,
                        color: getColor(),
                        child: Center(
                            child: Text(
                          "$ms",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Rubik'),
                        )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Metascore',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Rubik'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 330,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    jsonDecode(dataM)["Title"],
                    style: TextStyle(
                        fontSize:
                            jsonDecode(dataM)["Title"].length < 20 ? 30 : 24,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        jsonDecode(dataM)["Year"],
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        jsonDecode(dataM)["Rated"],
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        jsonDecode(dataM)["Runtime"],
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: <Widget>[
                      for (var genre in Genre)
                        GenreTag(
                          tag: genre,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text('Plot Summary',
                      style: TextStyle(fontSize: 20, fontFamily: 'Rubik')),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Text(
                      jsonDecode(dataM)["Plot"],
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          wordSpacing: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text('Cast & Crew',
                      style: TextStyle(fontSize: 20, fontFamily: 'Rubik')),
                  SizedBox(
                    height: 18,
                  ),
                  HomeScreen(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (var ac in Actors)
                          ActorAvatar(
                            actor: ac,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class GenreTag extends StatelessWidget {
  final String tag;

  const GenreTag({this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(20.0)),
      child: Text(tag,
          style: TextStyle(
              color: Colors.grey[700], fontSize: 15, fontFamily: 'Rubik')),
    );
  }
}

class ActorAvatar extends StatelessWidget {
  final String actor;
  const ActorAvatar({this.actor});

  @override
  Widget build(BuildContext context) {
    List clr = [
      0xFF5D686B,
      0xFF107895,
      0xFFC2561A,
      0xFFAC2A1A,
      0xFF083045,
      0xFF100B00,
      0xFF5B3758,
      0xFF14248A,
      0xFF28262C
    ];
    var r = new Random();
    int rc = r.nextInt(clr.length);
    int c = clr[rc];
    var s = actor[0] + actor[actor.indexOf(' ') + 1];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 38.0,
            backgroundColor: Color(c),
            child: Text(
              s.toString(),
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 30),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: actor.length > 10 ? 80 : 60,
              height: 40,
              child: Text(
                actor,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
              ]),
        ],
      ),
    );
  }
}
