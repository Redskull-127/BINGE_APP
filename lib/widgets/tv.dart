import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

import '../description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key key, this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (tv != null) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modified_text(
              text: 'TV series',
              color: Colors.red,
              size: 26,
            ),
            SizedBox(height: 10),
            Container(
                height: 270,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tv.length,
                    itemBuilder: (context, index) {
                      // var name;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Description(
                                name: tv[index]['original_name'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tv[index]['poster_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tv[index]['poster_path'],
                                description: tv[index]['overview'],
                                vote: tv[index]['vote_average'].toString(),
                                launch_on: tv[index]['first_air_date'],
                                url: tv[index]['original_name'],
                              ),
                            ),
                          );
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
                                          tv[index]['poster_path'],
                                    ),
                                  ),
                                ),
                                height: 200,
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: modified_text(
                                    size: 15,
                                    text: tv[index]['original_name'] != null
                                        ? tv[index]['original_name']
                                        : 'Loading'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      );
    } else if (tv == null) {
      return Center(child: Text('Something went wrong :('));
    }

    return CircularProgressIndicator();
  }
}
