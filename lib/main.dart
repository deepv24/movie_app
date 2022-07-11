import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = 'fc58da086cd1e513bfc2f6b0f9fa6a12';
  final String readacesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYzU4ZGEwODZjZDFlNTEzYmZjMmY2YjBmOWZhNmExMiIsInN1YiI6IjYyYmYwYTkzMTA1NjExMDA1YjVlNzIyMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yLb9GPU_BMPIOQnA-EhNMzhSH9E5vgRew_WIm-2mBX0';
  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbwithCustomlogs = TMDB(ApiKeys(apikey, readacesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmdbwithCustomlogs.v3.trending.getTrending();
    Map topratedresult = await tmdbwithCustomlogs.v3.movies.getTopRated();
    Map tvresult = await tmdbwithCustomlogs.v3.tv.getPouplar();
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: modified_text(
          text: 'flutter movie app 🎬',
          color: Colors.yellow,
          size: 28,
        ),
      ),
      body: ListView(
        children: [
          TV(tv: tv),
          TopRated(toprated: topratedmovies),
          TrendingMovies(trending: trendingmovies),
        ],
      ),
    );
  }
}
