import 'package:flutter/material.dart';
import '../first_screen.dart';
import 'package:picknic/first_screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/strings.dart';
import 'swiping_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Wrap(
                children: <Widget> [
                  ListTile(
                    title: Text(
                      details["name"],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)
                        ),
                        child: Image.network(
                          details["image_url"],
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                          child: Text("See business on Yelp", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
                          onTap: () async {
                            if (await canLaunch(details["url"])) {
                              await launch(details["url"]);
                            }
                          }
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: <Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                            "Rating: ${details["rating"]}"
                                        ),
                                        Icon(Icons.star),
                                        SizedBox(
                                            height: 20
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                        height: 20
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            "Categories:",
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                                        ),
                                        for (var category in details["categories"]) Text(category["title"]),
                                      ],
                                    )
                                  ]
                              ),
                              Column(
                                children: <Widget> [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget> [
                                        Icon(Icons.location_on_sharp),
                                        Text("${details["address_1"]} ${details["city"]}, ${details["state"]} ${details["zip_code"]}")
                                      ]
                                  ),
                                  SizedBox(
                                      height: 40
                                  ),
                                  Text("Dining Options:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                  for (var option in details["transactions"]) Text(option),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }


}
