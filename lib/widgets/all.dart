import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/utils/text.dart';

class Show {
  int malId;
  String title;
  String imageUrl;
  var score;

  Show({
    this.malId,
    this.title,
    this.imageUrl,
    this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

// ignore: must_be_immutable
void main() async {
  runApp(AnimeApp());
}

class AnimeApp extends StatefulWidget {
  final List all;
  const AnimeApp({Key key, this.all}) : super(key: key);

  @override
  _AnimeAppState createState() => _AnimeAppState();
}

class _AnimeAppState extends State<AnimeApp> {
  Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, AsyncSnapshot<List<Show>> snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      modified_text(
                        text: 'Anime',
                        color: Colors.red,
                        size: 28,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 270,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              // leading: CircleAvatar(
                              //   backgroundImage: NetworkImage(
                              //       '${snapshot.data[index].imageUrl}'),
                              // ),
                              // title:
                              //     Text('${snapshot.data[index].title}'),
                              // subtitle: Text(
                              //     'Score: ${snapshot.data[index].score}'),
                              child: Container(
                                width: 140,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${snapshot.data[index].imageUrl}',
                                          ),
                                        ),
                                      ),
                                      height: 190,
                                    ),
                                    SizedBox(height: 7),
                                    Container(
                                        child: modified_text(
                                      size: 13,
                                      text: ('${snapshot.data[index].title}'),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      )
                    ]));
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong :('));
          }

          return CircularProgressIndicator();
        },
        future: shows,
      ),
    );
  }
}
