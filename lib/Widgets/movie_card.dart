import 'package:flutter/material.dart';
import 'package:movie_review_app/Classes/dataclass.dart';
import 'package:movie_review_app/API/loading_data.dart';
import 'moviepage.dart';


class MovieCard extends StatefulWidget {
  final UserAccount user;
  final MovieFirst movie;

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: Border.all(color: Colors.deepOrange, width: 2),
        elevation: 8.0,
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Movie Poster
            Container(
              height: 190,
              width: 190,
              child: Image.network(
                widget.movie.posterPath,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Image not available',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            // Title and Rating Overlay
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Text(
                widget.movie.title,
                style: const TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.white54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow,),
                    Text(
                      widget.movie.ratings.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
      try {
        final MovieLast movie = await API().getMovieDetails(widget.movie.id);
        final List<Reviews> reviews = await API().getReviews(widget.movie.id);
        final List<MovieFirst> similarMovies = await API().getSimilar(widget.movie.id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MoviePages(movie: movie, reviews: reviews, similar: similarMovies, person: widget.user, movieID: widget.movie.id,)),
        );
      } catch (error) {
        print('Error fetching movie details: $error');
      }
    },
    );
  }
}
