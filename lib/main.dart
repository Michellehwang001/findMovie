import 'package:find_movie/movie_detail.dart';
import 'package:find_movie/widget/movie.dart';
import 'package:find_movie/widget/results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FindMovie(),
    );
  }
}

class FindMovie extends StatefulWidget {
  @override
  _FindMovieState createState() => _FindMovieState();
}

class _FindMovieState extends State<FindMovie> {
  final List<Results> filteredMovies = [];
  final List<Results> movies = [];
  final _controller = TextEditingController();

  // 영화정보 1페이지를 가져온다.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData().then((movie) {
      setState(() {
        //results = movie.results;
        movies.addAll(movie.results);
        print(movies[0].id);
      });
    });
  }

  Future<Movie> fetchData() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');
    var response = await http.post(uri);
    Movie movies = Movie.fromJson(json.decode(response.body));
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화 정보 검색기'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: '검색',
            ),
            onChanged: (value) {
              setState(() {
                filteredMovies.clear();
                filteredMovies
                    .addAll(movies.where((e) => e.title.contains(value)));
              });
            },
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 3,
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 4,
                children: _controller.text.isEmpty
                    ? _buildItem(movies, context)
                    : _buildItem(filteredMovies, context)
                // _buildItem(movies),
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItem(List<Results> movies, BuildContext context) {
    List<Widget> items = [];

    for (var movie in movies) {
      items.add(
        Column(
          children: [
            InkWell(
              child: Image.network(
                'https://image.tmdb.org/t/p/w500' + movie.posterPath,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie))),
              //onTap: Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie))),
            ),
            Text(movie.title),
          ],
        ),
      );
    }

    return items;
  }
}
