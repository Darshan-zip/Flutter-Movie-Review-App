import 'package:flutter/material.dart';
import 'package:movie_review_app/Pages/signup.dart';
import '../Classes/dataclass.dart';
import '../Database/database.dart';
import 'home_page.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap with Scaffold
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Material( // Wrap with Material
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Home Page',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      List<Map<String, dynamic>> queryResult =
                      await DatabaseHelper.instance
                          .querySingleUser(email, password);
                      if (queryResult.isNotEmpty) {
                        if (email == queryResult[0]['email'] &&
                            password == queryResult[0]['password']) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                user: UserAccount.fromMap(queryResult[0]),
                              ),
                            ),
                          );
                        } else {
                        error('user not found');
    }
                          // showDialog<void>(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text('Invalid Details'),
                          //       content: const SingleChildScrollView(
                          //         child: ListBody(
                          //           children: <Widget>[
                          //             Text('The details you entered are not valid. Please try again.'),
                          //           ],
                          //         ),
                          //       ),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           child: const Text('Ok'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        }else{
                        error('Incorrect Username/Password');
                      }
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Do not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future error(String text) {
    String errortext = text;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errortext),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}