import '../Classes/dataclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '316cbda136c47610993a50b3544d7985';

class API {
  //CONSTANTS
  final popularMovies = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
  final topRated = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

  //TO GET A LIST OF POPULAR MOVIES
  Future<List<MovieFirst>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularMovies));

    if (response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<MovieFirst> movies = data.map((movie) => MovieFirst.fromMap(movie)).toList();
      return movies;
    }
    else {
      throw Exception('Failed to load popular movies');
    }
  }

  //TO GET THE LIST OF TOP RATED MOVIES
  Future<List<MovieFirst>> getTopRated() async {
    final response = await http.get(Uri.parse(topRated));

    if (response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<MovieFirst> movies = data.map((movie) => MovieFirst.fromMap(movie)).toList();
      return movies;
    }
    else {
      throw Exception('Failed to load top rated movies');
    }
  }

  //TO GET THE FULL MOVIE DETAILS FROM THE `MOVIE ID`
  Future<MovieLast> getMovieDetails(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      return MovieLast.fromMap(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load top rated movies');
    }
  }

  //GET MOVIE REVIEWS FOR THE GIVEN `MOVIE ID`
  Future<List<Reviews>> getReviews(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Reviews> reviews = data.map((movie) => Reviews.fromMap(movie)).toList();
      return reviews;
    }
    else {
      throw Exception('Failed to load reviews');
    }
  }


  //GET SIMILAR MOVIES FROM THE PAGE OF A GIVEN MOVIE
  Future<List<MovieFirst>> getSimilar(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/$id/similar?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<MovieFirst> movies = data.map((movie) => MovieFirst.fromMap(movie)).toList();
      return movies;
    }
    else {
      throw Exception('Failed to load similar movies');
    }
  }


  //LOAD MOVIES FROM THE SEARCHED PATTERN
  Future<List<MovieFirst>> searchMovies(String pattern) async {
    String url = 'https://api.themoviedb.org/3/search/movie?query=$pattern&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<MovieFirst> movies = data.map((movie) => MovieFirst.fromMap(movie)).toList();
      return movies;
    }
    else {
      throw Exception('Failed to load searched movies');
    }
  }
}