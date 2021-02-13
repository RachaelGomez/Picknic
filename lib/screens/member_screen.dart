import 'package:flutter/material.dart';
import '../group_calls.dart';
import 'package:picknic/sign_in.dart';
import 'package:picknic/group_calls.dart';
import '../first_screen.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/login_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:picknic/group_calls.dart';

class MemberScreen extends StatefulWidget {
  final String groupName;
  final String hostName;

  final Future<http.Response> futureUpdate;
  const MemberScreen(
      {Key key, this.groupName, this.hostName, this.futureUpdate})
      : super(key: key);
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List membersArray = [];
  bool isLoading = true;
  bool isReady = true;
  @override
  void initState() {
    super.initState();
    this.fetchMembers(widget.groupName);
    this.checkSwiping(widget.groupName);
  }

  fetchMembers(groupName) async {
    setState(() {
      isLoading = true;
    });
    await widget.futureUpdate;
    var url = "http://localhost:3000/groups/$groupName/members";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        membersArray = items;
        isLoading = false;
        print(membersArray);
      });
    } else {
      membersArray = [];
      isLoading = false;
    }
  }

  checkSwiping(groupName) async {
    setState(() {
      isReady = true;
    });
    var url = "http://localhost:3000/groups/$groupName";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var item = json.decode(response.body);
      print(item);
      if (item["is_started"] == true) {
        setState(() {
          isReady = true;
        });
      } else {
        setState(() {
          isReady = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Picnic Waiting Room'), actions: <Widget>[
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
                'Host',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                widget.hostName,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'GROUP CODE',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                widget.groupName,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              // RaisedButton(
              //   onPressed: () {},
              //   color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Start the Picnic!',
              //       style: TextStyle(fontSize: 25, color: Colors.red[700]),
              //     ),
              //   ),
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(40)),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              Visibility(
                visible: isReady,
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Start Picknicing!',
                      style: TextStyle(fontSize: 25, color: Colors.red[700]),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
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
                onPressed: () {refreshPage();},
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
                'Members',
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

  // Widget isReadyButton() {
  //   return Visibility(
  //     visible: _isReady,
  //     child: RaisedButton(
  //       onPressed: () {},
  //       color: Colors.white,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(
  //           'Start Picknicing!',
  //           style: TextStyle(fontSize: 25, color: Colors.red[700]),
  //         ),
  //       ),
  //       elevation: 5,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     ),
  //   );
  // }

  Widget refreshPage() {
    setState(() => fetchMembers(widget.groupName));
    setState(() => checkSwiping(widget.groupName));
  }

  Widget getBody() {
    if (membersArray.length == 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.black)));
    }
    // return Center(child: Text(membersArray[0]["name"]));
    return Expanded(
      child: ListView.builder(
        itemCount: membersArray.length,
        itemBuilder: (context, index) {
          return getCard(membersArray[index]);
        },
      ),
    );
  }

  Widget getCard(item) {
    var name = item["name"];
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
                      name,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

    Widget startSwiping() {}
  }
}
