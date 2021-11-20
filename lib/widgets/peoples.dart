import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class Peoples extends StatelessWidget {
  final List peoples;

  const Peoples({Key key, this.peoples}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (peoples != null) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modified_text(
              text: 'Trending Today',
              color: Colors.red,
              size: 26,
            ),
            SizedBox(height: 10),
            Container(
                height: 270,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: peoples.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                        name: peoples[index]['title'],
                                        bannerurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                peoples[index]['backdrop_path'],
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                peoples[index]['poster_path'],
                                        description: peoples[index]['overview'],
                                        vote: peoples[index]['vote_average']
                                            .toString(),
                                        launch_on: peoples[index]
                                            ['release_date'],
                                        url: peoples[index]['title'],
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
                                            peoples[index]['poster_path']),
                                  ),
                                ),
                                height: 200,
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: modified_text(
                                    size: 15,
                                    text: peoples[index]['title'] != null
                                        ? peoples[index]['title']
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
    } else if (peoples == null) {
      return Center(child: Text('Something went wrong :('));
    }

    return CircularProgressIndicator();
  }
}
