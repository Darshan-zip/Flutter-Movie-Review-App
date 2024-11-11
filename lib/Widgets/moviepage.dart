import 'package:flutter/material.dart';
import 'package:movie_review_app/Database/database.dart';
import '../Classes/dataclass.dart';
import '../Pages/add_reviews_page.dart';
import 'movie_card.dart';
import 'reviews.dart';


class MoviePages extends StatefulWidget {
  final UserAccount person;
  final int movieID;
  final MovieLast movie;
  final List<Reviews> reviews;
  final List<MovieFirst> similar;

  const MoviePages({
    Key? key,
    required this.person,
    required this.movieID,
    required this.movie,
    required this.reviews,
    required this.similar,
  }) : super(key: key);

  @override
  State<MoviePages> createState() => _MoviePagesState();
}

class _MoviePagesState extends State<MoviePages> {
  late bool addToFavourites;
  @override
  void initState() {
    super.initState();
    initializeFavorites();
  }

  void initializeFavorites() async {
    // Call the asynchronous function to check if the movie is a favorite
    addToFavourites = await FavouritesDatabase.instance.isFavourite(widget.person.userId, widget.movieID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 61, 9),
        title: Text(widget.movie.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.movie.posterPath,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.movie.overview,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.deepOrange,),
                    Text(
                      widget.movie.voteAverage.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Text(
                  'Runtime: ${widget.movie.runtime} minutes',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: widget.movie.genres
                  .map((genre) => Chip(label: Text(genre)))
                  .toList(),
            ),
            Row(
              children: [
                const Text('Add to favorites?', style: TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(width: 10),
                Checkbox(
                  value: addToFavourites,
                  activeColor: Colors.deepOrange, // Amber color when not checked
                  onChanged: (value) {
                    setState(() {
                      addToFavourites = value!;
                      if (addToFavourites == true) {
                        FavouritesDatabase.instance.insertUser({
                          'person_id': widget.person.userId,
                          'movie_id': widget.movieID
                        });
                      }
                      else {
                        FavouritesDatabase.instance.deleteFavorite(widget.person.userId, widget.movieID);
                      }
                    });
                  },
                ),
              ],
            ),
            Row(children: [
              Text('REVIEWS (${widget.reviews.length})', style: const TextStyle(fontSize: 20, color: Colors.white),),
              const SizedBox(width: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 233, 61, 9)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddYourReview(user: widget.person, title: widget.movie.title),));
                  },
                  child: const Text('Add Your Review?',style: TextStyle(fontSize: 20, color: Colors.white),))
            ],),
            Expanded(
                child: ListView.builder(itemCount: widget.reviews.length, itemBuilder: (context, index) => ReviewCard(review: widget.reviews[index]),)
            ),
            const SizedBox(height: 5,),
            Text('Movies similar to ${widget.movie.title}', style: const TextStyle(color: Colors.white, fontSize: 10),),
            Expanded(
              child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: widget.similar.length, itemBuilder: (context, index) => MovieCard(movie: widget.similar[index], user: widget.person,),),
            )
          ],
        ),
      ),
    );
  }
}