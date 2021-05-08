import 'package:find_movie/movie_detail.dart';
import 'package:find_movie/movie_provider.dart';
import 'package:find_movie/widget/movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FindMovie(),
      ),
    );
  }
}

class FindMovie extends StatefulWidget {
  @override
  _FindMovieState createState() => _FindMovieState();
}

class _FindMovieState extends State<FindMovie> {
  final List<Movie> filteredMovies = [];
  List<Movie> movies = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<MovieProvider>().fetchData();
    Provider.of<MovieProvider>(context, listen: false).fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Provider를 제공받는다.
    MovieProvider movieProvider = Provider.of<MovieProvider>(context);
    if(movieProvider.isDone == true) {
      movies = movieProvider.movies.results;
    }

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
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItem(List<Movie> movies, BuildContext context) {
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
            ),
            Text(movie.title),
          ],
        ),
      );
    }

    return items;
  }
}
