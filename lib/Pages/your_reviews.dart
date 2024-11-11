import 'package:flutter/material.dart';
import '../Database/database.dart';
import '../Widgets/reviews.dart';



class YourReviews extends StatefulWidget {
  final int userID;
  const YourReviews({Key? key, required this.userID}) : super(key: key);
  @override
  State<YourReviews> createState() => _YourReviewsState();
}

class _YourReviewsState extends State<YourReviews> {
  List<YourReviewsCard> reviews = []; // Placeholder for fetched reviews

  @override
  void initState() {
    super.initState();
    fetchUserReviews();
  }

  Future<void> fetchUserReviews() async {
    // Simulate fetching user reviews from a database asynchronously
    List<Map<String, dynamic>> map = await ReviewsDatabase.instance.getAllReviews(widget.userID);
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      for (Map<String, dynamic> i in map) {
        reviews.add(
            YourReviewsCard(
              movieName: i['title'],
              ratings: i['rating'],
              reviewContent: i['content'],
              username: i['name'],
            )
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Your Reviews'),
      ),
      body: Column(
        children: [
          const Center(
              child: Text(
                "Your Reviews:",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              )
          ),
          Expanded(child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) => reviews[index]
            ,)
          )
        ],
      ),
    );
  }
}