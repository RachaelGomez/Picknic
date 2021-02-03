import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'swipe_page.dart';


import 'login_page.dart';

Future main() async {
  // await DotEnv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: SwipePage(),
    );
  }
}

// class SwipePage extends StatefulWidget {
//   final dio = Dio()
//   _SwipePageState createState() => _SwipePageState();
// }
//
// class _SwipePageState extends State<SwipePage> {
//   void restaurantResults(String query) async {
//     final response = await widget.dio.get('https://api.yelp.com/v3/businesses/search'), queryParameters: {
//
//     }
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }