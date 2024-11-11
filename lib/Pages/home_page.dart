import 'package:flutter/material.dart';
import 'package:movie_review_app/Pages/register_page.dart';
import 'package:movie_review_app/Pages/your_reviews.dart';
import '../Classes/dataclass.dart';
import 'movies_page.dart';



class HomePage extends StatelessWidget {
  final UserAccount user;
  const HomePage({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Home"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                Text("${user.firstName} ${user.lastName}",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                IconButton(
                  icon: const Icon(Icons.logout_rounded,color: Colors.white),
                  onPressed: (){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Are you sure you want to log out of this account?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                // Add your logic here for confirmed action
                                // For example, you can perform some action and then close the dialog
                                // YourLogic.confirmAction();
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  tooltip: 'Logout',
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 2.5),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Movies(user: user),
                        ));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                  child: const Text('Go to Movies',style:TextStyle(color: Colors.black,fontSize: 15)),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourReviews(userID: user.userId),
                        ));
                  },
                  child: const Text('Go to Your Reviews',style:TextStyle(color:Colors.black,fontSize: 15)),
                ),
              ],
            ),
            Expanded(
              child: Image.network('https://cdn.discordapp.com/attachments/1038426821114462260/1208403199359455252/e9ad0190-4dad-4aa1-9123-4dac4988dcb5.png?ex=65e3282d&is=65d0b32d&hm=19c1a656405d0d658c3bd7af5985704be57b787eb38bdd672b30cd17082b3a0c&',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}