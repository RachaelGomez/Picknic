import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknic/Constants/strings.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/group_calls.dart';
import 'package:picknic/sign_in.dart';
import 'member_screen.dart';



class JoinGroupScreen extends StatefulWidget {
  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  List groups = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchGroup();
  }

  fetchGroup() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://localhost:3000/groups";
    var response = await http.get(url);

    if(response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        groups = items;
        isLoading = false;
      });
    } else {
      groups = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Join group'),
          actions: <Widget>[
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
            )
          ]
      ),
      body: getBody(),
    );
  }
  Widget getBody() {
    if(groups.contains(null) || groups.length < 0 || isLoading) {
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(Colors.black)));
    }
    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return getCard(groups[index]);
        });
  }
  Widget getCard(item) {
    var groupName = item['group_name'];
    var hostName = item['host_name'];
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
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 140,
                      child: Text(groupName, style: TextStyle(fontSize: 17),)),
                  SizedBox(height: 10,),
                  Text("Host: $hostName", style: TextStyle(color: Colors.grey),),
                  RaisedButton(
                      onPressed: () {
                        var futureUpdate = updateUser(uid, Strings.localHostUrl, groupName);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MemberScreen(groupName: groupName, hostName: hostName, futureUpdate: futureUpdate,);
                            },
                          ),
                        );
                      },
                  color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Join Group',
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