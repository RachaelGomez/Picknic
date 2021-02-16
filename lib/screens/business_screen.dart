import 'package:flutter/material.dart';
import '../first_screen.dart';
import 'package:picknic/first_screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/strings.dart';
import 'swiping_screen.dart';
import 'package:flutter/cupertino.dart';

class BusinessScreen extends StatefulWidget {
  final Future<dynamic> restaurant;
  final Future<http.Response> future;

  const BusinessScreen({Key key, this.restaurant, this.future})
      : super(key: key);
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  Map details = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    this.fetchBusinessDetails(widget.restaurant);
  }

  fetchBusinessDetails(yelpId) async {
    setState(() {
      isLoading = true;
    });
    await widget.restaurant;
    await widget.future;
    var realYelpId = await yelpId;
    var url = "http://localhost:3000/details/$realYelpId";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        details = items;
        isLoading = false;
        print(details);
      });
    } else {
      details = {};
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Details'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          },
        ),
      ]),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.red[800], Colors.red[400]],
          ),
        ),
        child: Center(
          child: Container(
            height: 500,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          details["image_url"],
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                  Text(details['name']),
                  Text(details['price']),
                  Text(details['phone']),
                  Text(details['rating'].toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
