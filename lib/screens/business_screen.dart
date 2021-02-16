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

  const BusinessScreen({Key key, this.restaurant, this.future}) : super(key: key);
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
      appBar: AppBar(title: const Text('Votes Are In!'), actions: <Widget>[
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  details['name'],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                // Text(
                //   style: TextStyle(
                //       fontSize: 25,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold),
                // ),
                SizedBox(height: 20),
              ]),
        ),
      ),
    );
  }

  Widget getBody() {
    if (details.length == 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.black)));
    }
    // return Center(child: Text(membersArray[0]["name"]));
    return Expanded(
      child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          String key = details.keys.elementAt(index);
          return getCard(details[index], key);
        },
      ),
    );
  }

  Widget getCard(item, key) {
    var restaurant = item;
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(60 / 2),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Text(
                      key,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
