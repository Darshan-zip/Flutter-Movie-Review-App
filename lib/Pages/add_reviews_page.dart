import 'package:flutter/material.dart';
import '../Classes/dataclass.dart';
import '../Database/database.dart';



class AddYourReview extends StatefulWidget {
  final UserAccount user;
  final String title;

  const AddYourReview({Key? key, required this.user, required this.title}) : super(key: key);
  @override
  State<AddYourReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddYourReview>{
  TextEditingController searchController = TextEditingController();
  int _selectedStars = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 109, 10),
        title: const Text("Add Your Review"),
        centerTitle: true,
      ),
      body: Column(children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(10, (index) {
            return GestureDetector(
              onTap: () {
                // Update the selected stars when a star is tapped
                setState(() {
                  _selectedStars = index + 1;
                });
              },
              child: Icon(
                index < _selectedStars ? Icons.star : Icons.star_border,
                color: Colors.yellow,
                size: 30.0,
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        TextField(
            style: const TextStyle(color: Colors.white),
            controller: searchController
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 231, 109, 10) ),
          onPressed: () {
            String enteredText = searchController.text;
            //enteredText holds written review
            //_selectedStars holds star-rating value
            ReviewsDatabase.instance.insertUser({
              'person_id': widget.user.userId,
              'name': '${widget.user.firstName} ${widget.user.lastName}',
              'rating': _selectedStars,
              'content': enteredText,
              'title': widget.title,
            });
            Navigator.pop(context);
          },
          child: const Text('Submit',style: TextStyle(color: Colors.white),),
        ),
      ],
      ),
    );
  }
}