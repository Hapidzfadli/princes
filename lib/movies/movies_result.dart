import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieResult {
  // late List<dynamic>? id;
  // late List<dynamic>? title;
  // late List<dynamic>? panjang;
  //
  // MovieResult({this.id, this.title});
  //
  //
  // factory MovieResult.createMovieResult(List<dynamic> object){
  //   var result;
  //   var idMovie;
  //   var titlemovie;
  //   for (var i = 0; i < object.length; i++){
  //     idMovie[i] = object[i]['id'];
  //     titlemovie![i] = object[i]['title'];
  //   }
  //   result = MovieResult(
  //     id: idMovie,
  //     title: titlemovie,
  //   );
  //   return result;
  // }
  //
  // static Future<MovieResult> connectApi (String urlQuery, String urlValue) async {
  //   String apiUrl = urlQuery + urlValue;
  //   final response = await http.get(Uri.parse(apiUrl));
  //   if(response.statusCode == 200) {
  //     return MovieResult.createMovieResult(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load url');
  //   }
  // }

  Future<List> getData(String urlQuery, String urlValue) async {
    String apiUrl = urlQuery + urlValue;
    List movieData;
    final response = await http.get(Uri.parse(apiUrl));
    movieData = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return movieData;
    } else {
      throw Exception('Failed to load url');
    }
  }

}