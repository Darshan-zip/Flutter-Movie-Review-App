import 'package:flutter/material.dart';
import '../API/loading_data.dart';
import '../Classes/dataclass.dart';
import '../Widgets/movie_card.dart';



class SearchPage extends StatefulWidget {
  final UserAccount user;
  const SearchPage({super.key, required this.user});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  var searchedMovies = Future.value([]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            "Search for Movies",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          style: const TextStyle(color: Colors.white),
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search for movies',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Trigger search when the user presses the search icon
                setState(() {
                  // Update searchedMovies with the results from the API
                  searchedMovies = API().searchMovies(searchController.text);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: searchedMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: snapshot.data![index], user: widget.user,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}