import 'package:find_movie/widget/movie.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  Movie result = Movie();

  //final items = List.generate(50, (i) => i).toList();

  MovieDetail(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500' + result.posterPath,
                  width: 150,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  result.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(result.overview)
            // SingleChildScrollView(
            //     child: ListBody(
            //       children: items.map((e) => Text('$e')).toList(),
            //         //items.map((e) => Text('$e')).toList();
            //     )
            //     //Text(result.overview)
            // ),
          ],
        ),
      ),
    );
  }
}
