import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:picknic/first_screen.dart';
import '../restaurant_calls.dart';
import 'business_screen.dart';

class SummaryScreen extends StatefulWidget {
  final String groupName;

  const SummaryScreen(
      {Key key, this.groupName })
      : super(key: key);
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  Map votesArray = {};
  bool isLoading = true;
  List winner = [];

  @override
  void initState() {
    super.initState();
    this.fetchVotes(widget.groupName);
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
      setState(() {
        votesArray = {};
        isLoading = false;
      });

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

  getRestaurant(name) async {
    var restaurant = await fetchRestaurant(name);
    return restaurant;
  }

  // awaitWinner() {
  //   winner = await winner
  // }

  


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
            colors: [Colors.red[800], Colors.deepOrange[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 40),

              Text(
                'and the winner is...',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              getWinner(),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
              ),
              Text(
                "Refresh Page",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: () {
                  refreshPage();
                },
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.refresh),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Votes',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 40,
              ),
              getBody()
            ],
          ),
        ),
      ),
    );
  }


  Widget refreshPage() {
    fetchVotes(widget.groupName);
    fetchWinner(widget.groupName);
  }

  Widget getWinner() {
    print(winner);
    if (winner == null || winner.length == 0) {
      return Text('Counting the Votes!');
    } else {
      return Text(
      "'${winner[0].toString()} with ${winner[1].toString()} votes!",
      style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );

    }
  }

  Widget getBody() {
    if (votesArray.length == 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.black)));
    }
    // return Center(child: Text(membersArray[0]["name"]));
    return Expanded(
      child: ListView.builder(
        itemCount: votesArray.length,
        itemBuilder: (context, index) {
          String key = votesArray.keys.elementAt(index);
          return getCard(votesArray[index], key);
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
                  Text(
                    "Votes: ${votesArray[key]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  RaisedButton(
                    onPressed: () {
                      var restaurant = getRestaurant(key);
                      var futureDetail = createDetails(restaurant);
                      print(restaurant);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return BusinessScreen(restaurant: restaurant, future: futureDetail);
                          },
                        ),
                      );
                    },
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Get Details',
                        style: TextStyle(fontSize: 25, color: Colors.red[700]),

                      ),
                    ),
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
