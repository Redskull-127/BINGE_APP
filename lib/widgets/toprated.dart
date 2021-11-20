import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key key, this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (toprated != null) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modified_text(
              text: 'TOP-RATED movies',
              color: Colors.red,
              size: 26,
            ),
            SizedBox(height: 10),
            Container(
                height: 270,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: toprated.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                        name: toprated[index]['title'],
                                        bannerurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                toprated[index]
                                                    ['backdrop_path'],
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                toprated[index]['poster_path'],
                                        description: toprated[index]
                                            ['overview'],
                                        vote: toprated[index]['vote_average']
                                            .toString(),
                                        launch_on: toprated[index]
                                            ['release_date'],
                                        url: toprated[index]['title'],
                                      )));
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
                                            toprated[index]['poster_path']),
                                  ),
                                ),
                                height: 200,
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: modified_text(
                                    size: 15,
                                    text: toprated[index]['title'] != null
                                        ? toprated[index]['title']
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
    } else if (toprated == null) {
      return Center(child: Text('Something went wrong :('));
    }

    return CircularProgressIndicator();
  }
}
