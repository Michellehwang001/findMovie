// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:find_movie/widget/movies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  test('http 통신 테스트', () async {
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');
    var response = await http.get(uri);
    expect(response.statusCode, 200);

    Movies movie = Movies.fromJson(json.decode(response.body));
    expect(movie.results[0].id, 460465);

   // Subway sub = Subway.fromJson(json.decode(response.body));
    // expect(sub.realtimeArrivalList[0].statnNm, '대야미');
  });
}
