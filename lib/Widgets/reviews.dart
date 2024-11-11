import 'package:flutter/material.dart';
import 'package:movie_review_app/Classes/dataclass.dart';

class ReviewCard extends StatelessWidget {
  final Reviews review;

  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: Border.all(color: Colors.deepOrange, width: 4),
        elevation: 6.0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Colors.orange[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          review.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  review.content,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YourReviewsCard extends StatelessWidget {
  final String movieName;
  final String username;
  final int ratings;
  final String reviewContent;
  const YourReviewsCard({super.key,
    required this.movieName,
    required this.username,
    required this.ratings,
    required this.reviewContent,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      shape: Border.all(color: Colors.deepOrange, width: 3,),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                movieName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Set text color to deepOrange
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Set text color to black
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.star, // Use star icon instead of "Ratings"
                  color: Colors.deepOrange, // Set star color to deepOrange
                ),
                Text(
                  '$ratings/10',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Set text color to black
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Review:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              reviewContent,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Set text color to black
              ),
            ),
          ],
        ),
      ),
    );
  }
}


