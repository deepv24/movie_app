import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import '../description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
              text: 'TrendingMovies', color: Colors.yellowAccent, size: 26),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 270,
            child: ListView.builder(
              itemCount: trending.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: trending[index]['title'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500' +
                              trending[index]['backdrop_path'],
                          posterurl: 'https://image.tmdb.org/t/p/w500' +
                              trending[index]['poster_path'],
                          desription: trending[index]['overview'],
                          vote: trending[index]['vote_average'].toString(),
                          launch_on: trending[index]['release_date'],
                        ),
                      ),
                    );
                  },
                  child: trending[index]['title'] != null
                      ? Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path']),
                                  ),
                                ),
                              ),
                              Container(
                                child: modified_text(
                                  text: trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : 'loading',
                                  color: Colors.white,
                                  size: 17,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
