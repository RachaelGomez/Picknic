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
  final Future<http.Response> restaurant;

  const BusinessScreen(
      {Key key, this.restaurant })
      : super(key: key);
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  Map votesArray = {};
  bool isLoading = true;
  List winner = [];

  @override



  void initState() {
    super.initState();
    this.fetchBusinessDetails(widget.restaurant);
    this.fetchWinner(widget.groupName);
  }

  fetchVotes(groupName) async {
    setState(() {
      isLoading = true;
    });
    // await widget.futureUpdate;
    var url = "http://localhost:3000/groups/$groupName/total_votes";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        votesArray = items;
        isLoading = false;
        print(votesArray);
      });
    } else {
      votesArray = {};
      isLoading = false;
    }
  }

  fetchWinner(groupName) async {
    // await widget.futureUpdate;
    var url = "http://localhost:3000/groups/$groupName/winner";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var item = json.decode(response.body);
      setState(() {
        winner = item;
      });
    } else {
      winner = [];
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