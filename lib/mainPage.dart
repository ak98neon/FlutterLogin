import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_page/main.dart';
import 'package:flutter_login_page/model/applicationForm.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'fmpDetailScreen.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainRoute> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: fetchApplicationForms(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.query_builder)),
                  Tab(icon: Icon(Icons.message)),
                ],
              ),
              title: Text("FMR"),
            ),
            body: TabBarView(
              children: <Widget>[
                futureBuilder,
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            )),
      ),
    );
  }

  Future<String> fetchApplicationForms() async {
    var token = await storage.read(key: "jwt");
    final http.Response response = await http.get(
      'http://10.0.2.2:8080/forms',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    );
    return response.body;
  }

  var formatter = new DateFormat('MMMMEEEEd');

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    String formsJson = snapshot.data;
    var tagObjsJson = jsonDecode(formsJson)['Value'] as List;
    List<ApplicationForm> forms = tagObjsJson
        .map((tagJson) => ApplicationForm.fromJson(tagJson))
        .toList();
    return ListView.builder(
      itemCount: forms.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text(
                formatter.format(DateTime.parse(forms[index].missionDate)),
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(forms[index].departureCity.name +
                " - " +
                forms[index].destinationCity.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FmpDetailScreen(
                          id: forms[index].id,
                          departureCity: forms[index].departureCity,
                          destinationCity: forms[index].destinationCity,
                        )),
              );
            },
          ),
        );
      },
    );
  }
}
