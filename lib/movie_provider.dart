import 'package:find_movie/widget/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieProvider with ChangeNotifier{
  Movies _movies;
  bool _isDone = false;

  Movies get movies => _movies;
  bool get isDone => _isDone;

  Future<Movies> _fetchData() async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');
    var response = await http.post(uri);
    Movies movies = Movies.fromJson(json.decode(response.body));
    return movies;
  }

  void fetchData() {
    _fetchData().then((movies) {
      _movies = movies;
      _isDone = true;
      notifyListeners();
    });
  }

}
