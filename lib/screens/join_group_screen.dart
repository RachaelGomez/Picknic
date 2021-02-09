import 'package:flutter/material.dart';
import 'package:picknic/network_helper.dart';
import 'package:picknic/models.dart';


class JoinGroupScreen extends StatefulWidget {
  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.red[800], Colors.red[400]]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              // RaisedButton(
              //   onPressed: () {},color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Sign Out',
              //       style: TextStyle(fontSize: 25, color: Colors.red[700]),
              //     ),
              //   ),
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(40)),

              //)

            ]
          ),
          child: _groupsData();

        ),
      )
    );
  }
}

FutureBuilder _groupsData() {
  return FutureBuilder<List<Groups>>(
    future: GetGroup().getGroups(),
    builder: (BuildContext context, AsyncSnapshot<List<Groups>> snapshot) {
      if (snapshot.hasData) {
        List<Groups> data = snapshot.data;
        return _groups(data);
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
    }
  );
}

ListView _groups(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            child: _tile(data[index].employeeName, data[index].employeeSalary, Icons.work)
        );
      }
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
