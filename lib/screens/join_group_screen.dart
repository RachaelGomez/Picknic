import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picknic/Constants/strings.dart';
import 'package:picknic/group_calls.dart';
import 'package:picknic/sign_in.dart';


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
    var hostId = item['host_id'];
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
                  Text(hostId, style: TextStyle(color: Colors.grey),),
                  RaisedButton(
                      onPressed: () {
                        print('Calling update user');
                        updateUser(uid, Strings.localHostUrl, groupName);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




