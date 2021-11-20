import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class Persons extends StatelessWidget {
  final List personn;

  const Persons({Key key, this.personn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (personn != null) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modified_text(
              text: 'Popular Persons',
              color: Colors.red,
              size: 26,
            ),
            SizedBox(height: 10),
            Container(
                height: 270,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: personn.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Description(
                          //               name: person[index]['title'],
                          //               bannerurl:
                          //                   'https://image.tmdb.org/t/p/w500' +
                          //                       person[index]['backdrop_path'],
                          //               posterurl:
                          //                   'https://image.tmdb.org/t/p/w500' +
                          //                       person[index]['poster_path'],
                          //               description: person[index]['overview'],
                          //               vote: person[index]['vote_average']
                          //                   .toString(),
                          //               launch_on: person[index]
                          //                   ['release_date'],
                          //               url: person[index]['title'],
                          //             )));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            personn[index]['poster_path']),
                                  ),
                                ),
                                height: 200,
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: modified_text(
                                    size: 15,
                                    text:
                                        personn[index]['original_title'] != null
                                            ? personn[index]['original_title']
                                            : 'Loading'),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      );
    } else if (personn == null) {
      return Center(child: Text('Something went wrong :('));
    }

    return CircularProgressIndicator();
  }
}
