import 'package:flutter/material.dart';
import 'package:movie_review_app/Pages/search_page.dart';

import '../API/loading_data.dart';
import '../Classes/dataclass.dart';
import '../Database/database.dart';
import '../Widgets/movie_card.dart';

class Movies extends StatefulWidget {
  final UserAccount user;

  const Movies({super.key, required this.user});
  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  int _selectedIndex = 0;
  late Future<List<MovieFirst>> popularMovies;
  late Future<List<MovieFirst>> topRated;
  late List<Widget> _widgetOptions = [];
  late Future<List<MovieFirst>> searchedMovies;
  late List<MovieFirst> favouriteMovies = [];

  @override
  void initState() {
    super.initState();
    initializeData(); // Call initializeData() here
  }

  void initializeData() async {
    // Fetch popular movies and top rated movies simultaneously
    final popularMoviesFuture = API().getPopularMovies();
    final topRatedFuture = API().getTopRated();
    popularMovies = popularMoviesFuture;
    topRated = topRatedFuture;

    // Wait for both futures to complete
    await Future.wait([popularMoviesFuture, topRatedFuture]);

    // Fetch favorite movie IDs from the database
    List<int> ids = [];
    final favourites = await FavouritesDatabase.instance.getFavourites(widget.user.userId);
    for (Map<String, dynamic> i in favourites) {
      ids.add(i['movie_id']);
    }
    List<MovieLast> movieList = [];
    for (int i in ids) {
      movieList.add(await API().getMovieDetails(i));
    }

    // Initialize favouriteMovies inside setState
    setState(() {
      for (int i = 0; i < ids.length; i++) {
        favouriteMovies.add(MovieFirst(
          id: ids[i],
          title: movieList[i].title,
          posterPath: movieList[i].posterPath,
          ratings: movieList[i].voteAverage,
        ));
      }
    });
    _widgetOptions = [
      Column(
        children: [
          const Center(
              child: Text(
                "Popular",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: snapshot.data![index],
                        user: widget.user,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      Column(
        children: [
          const Center(
              child: Text(
                "Top-Rated",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: topRated,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: snapshot.data![index],
                        user: widget.user,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      Column(
        children: [
          const Center(
            child: Text(
              "Your Favorites",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder<List<MovieFirst>>(
              future: popularMovies, // Use any future here, since it's not important for this widget
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: favouriteMovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: favouriteMovies[index],
                        user: widget.user,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      SearchPage(user: widget.user,)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Movies'),
      ),
      body: _widgetOptions.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator if _widgetOptions is empty
          : _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.black,
              ),
              label: 'Popular',
              tooltip: 'Popular Movies'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                color: Colors.black,
              ),
              label: 'Top-Rated',
              tooltip: 'Top-Rated Movies'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.thumb_up_sharp,
                color: Colors.black,
              ),
              label: 'Favorites',
              tooltip: 'Your Favourites'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              label: 'Search',
              tooltip: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 253, 245, 8),
        onTap: _onItemTapped,
      ),
    );
  }
}