// CLASS TO CREATE MOVIE CARD
class MovieFirst {
  final int id;
  final String title;
  final String posterPath;
  final double ratings;

  MovieFirst({required this.id, required this.title, required this.posterPath, required this.ratings});

  factory MovieFirst.fromMap(Map<String, dynamic> map) {
    return MovieFirst(
        id: map['id'],
        title: map['title'],
        ratings: map['vote_average'],
        posterPath: 'https://image.tmdb.org/t/p/original/${map['poster_path']}'
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'title': title,
      'vote_average': ratings,
      'posterPath': posterPath
    };
  }
}




//HELPER FUNCTIONS
List<String> getGenres(Map<String, dynamic> map) {
  List<String> genres = [];
  for (Map<String,dynamic> i in map['genres']) {
    genres.add(i['name']);
  }
  return genres;
}






// CLASS TO CREATE MOVIE PAGE FOR A SINGLE MOVIE
class MovieLast {
  final String title;
  final String posterPath;
  final String overview;
  final List<String> genres;
  final int runtime;
  final double voteAverage;

  MovieLast({required this.title, required this.posterPath, required this.overview, required this.genres, required this.runtime, required this.voteAverage});


  factory MovieLast.fromMap(Map<String, dynamic> map) {

    return MovieLast(
        title: map['title'],
        posterPath: 'https://image.tmdb.org/t/p/original/${map['poster_path']}',
        overview: map['overview'],
        genres: getGenres(map),
        runtime: map['runtime'],
        voteAverage: map['vote_average']
    );
  }
}




//REVIEWS CLASS
class Reviews {
  final String author;
  final double rating;
  final String content;

  Reviews({required this.author, required this.content, required this.rating});
  //HAVE TO GO INSIDE RESULTS LATER
  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
        author: map['author'],
        content: map['content'],
        rating: map['author_details']['rating'] ?? 0
    );
  }
}



class UserAccount {
  final String firstName;
  final String lastName;
  final int userId;

  UserAccount({required this.firstName, required this.lastName, required this.userId});

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
        firstName: map['first_name'],
        lastName: map['last_name'],
        userId: map['person_id']
    );
  }
}