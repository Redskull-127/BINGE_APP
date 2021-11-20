import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../unityad.dart';
import 'movie_detail.dart';
import 'star_display.dart';

class Movie extends StatefulWidget {
  final Response data;
  Movie({this.data});

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var Genre = [];
    final dataM = widget.data.body;
    Genre = processGenre(jsonDecode(dataM)['Genre']).split(", ");
    if (Genre.length > 3) {
      while (Genre.length != 3) {
        Genre.removeLast();
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(jsonDecode(dataM)['Poster']),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              top: 20,
                              left: 20,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                              )),
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      topLeft: Radius.circular(50))),
                              width: 270,
                              height: 530,
                            ),
                          ),
                          Positioned(
                            top: 27,
                            left: 18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: 'photo',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.network(
                                      jsonDecode(dataM)['Poster'],
                                      width: 200,
                                      height: 297,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
//                                Text(
//                                  jsonDecode(dataM)['Title'],
////                                  maxLines: 2,
//                                  style: TextStyle(
//                                    fontSize: 30,
////                                      fontSize: jsonDecode(dataM)['Title'].length > 16 ? 17 : 30,
//                                      fontWeight: FontWeight.w500,
//                                      fontFamily: "Rubik"),
//                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 55, maxWidth: 230),
                                  child: AutoSizeText(
                                    jsonDecode(dataM)['Title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
//                                      fontSize: jsonDecode(dataM)['Title'].length > 16 ? 17 : 30,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Rubik"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
//                                    Container(
//                                      padding: EdgeInsets.symmetric(
//                                          vertical: 5.0, horizontal: 10.0),
//                                      decoration: BoxDecoration(
//                                          border:
//                                          Border.all(color: Colors.grey[700]),
//                                          borderRadius:
//                                          BorderRadius.circular(20.0)),
//                                      child: Text(
//                                          Genre[0],
//                                          style: TextStyle(
//                                              color: Colors.grey[700],
//                                              fontSize: 12,
//                                              fontFamily: 'Rubik')),
//                                    ),
//                                    SizedBox(
//                                      width: 5.0,
//                                    ),
//                                    Container(
//                                      padding: EdgeInsets.symmetric(
//                                          vertical: 5.0, horizontal: 10.0),
//                                      decoration: BoxDecoration(
//                                          border:
//                                          Border.all(color: Colors.grey[700]),
//                                          borderRadius:
//                                          BorderRadius.circular(20.0)),
//                                      child: Text(
//                                        Genre[1],
//                                        style: TextStyle(
//                                            color: Colors.grey[700],
//                                            fontSize: 12,
//                                            fontFamily: 'Rubik'),
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      width: 5.0,
//                                    ),
//                                    Container(
//                                      padding: EdgeInsets.symmetric(
//                                          vertical: 5.0, horizontal: 10.0),
//                                      decoration: BoxDecoration(
//                                          border:
//                                          Border.all(color: Colors.grey[700]),
//                                          borderRadius:
//                                          BorderRadius.circular(20.0)),
//                                      child: Text(Genre[2],
//                                          style: TextStyle(
//                                              color: Colors.grey[700],
//                                              fontSize: 12,
//                                              fontFamily: 'Rubik')),
//                                    )
                                    for (var genre in Genre)
                                      GenreTag(
                                        tag: genre,
                                      )
                                  ],
                                ),
//                              Expanded(
//                                child: ListView.builder(
//                                  scrollDirection: Axis.horizontal,
//                                    shrinkWrap: true,
//                                    itemBuilder:(context, index){
//                                      return Container(
//                                        padding: EdgeInsets.symmetric(
//                                            vertical: 5.0, horizontal: 10.0),
//                                        decoration: BoxDecoration(
//                                            border:
//                                            Border.all(color: Colors.grey[700]),
//                                            borderRadius:
//                                            BorderRadius.circular(20.0)),
//                                        child: Text(Genre[index],
//                                            style: TextStyle(
//                                                color: Colors.grey[700],
//                                                fontSize: 12,
//                                                fontFamily: 'Rubik')),
//                                      );
//                                    }),
//                              ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      jsonDecode(dataM)["imdbRating"],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Rubik'),
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    StarDisplay(
                                        value: double.parse(jsonDecode(
                                                        dataM)["imdbRating"] ==
                                                    "N/A"
                                                ? "0"
                                                : jsonDecode(
                                                    dataM)["imdbRating"]) /
                                            2),
                                  ],
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 57.0, vertical: 15.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
//                                      PageRouteBuilder(
//                                          transitionDuration: Duration(milliseconds: 1000),
//                                          transitionsBuilder: (context, animation, secAnimation, child) {
//                                            animation = CurvedAnimation(
//                                                parent: animation, curve: Curves.elasticInOut);
//                                            return ScaleTransition(
//                                                alignment: Alignment.center,
//                                                scale: animation,
//                                                child: child);
//                                          },
//                                          pageBuilder: (context, animation, secAnimation) {
//                                            return MovieDetails(data: widget.data);
//                                          }),
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetails(
                                                  data: widget.data,
                                                )));
                                  },
                                  color: Color(0xFF313131),
                                  child: Text(
                                    'CHECK OUT MORE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Rubik'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          HomeScreen(),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String processGenre(genre) {
    if (genre.length > 26) {
      genre = genre.substring(0, 26);
      var c = genre.substring(genre.length - 1);
      while (c != ',') {
        genre = genre.substring(0, genre.length - 1);
        c = genre.substring(genre.length - 1);
      }
      genre = genre.substring(0, genre.length - 1);
      return genre;
    } else {
      return genre;
    }
  }
}

class GenreTag extends StatelessWidget {
  final String tag;

  const GenreTag({this.tag});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[700]),
          borderRadius: BorderRadius.circular(20.0)),
      child: Text(tag,
          style: TextStyle(
              color: Colors.grey[700], fontSize: 12, fontFamily: 'Rubik')),
    );
  }
}
