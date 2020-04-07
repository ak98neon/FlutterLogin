import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/city.dart';

class FmpDetailScreen extends StatelessWidget {
  final int id;
  final City departureCity;
  final City destinationCity;

  FmpDetailScreen(
      {@required this.id,
      @required this.departureCity,
      @required this.destinationCity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FMP"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'Id: ' + this.id.toString(),
                textAlign: TextAlign.left,
              ),
              Text(
                'City departure: ' + this.departureCity.name,
                textAlign: TextAlign.left,
              ),
              Text(
                'City destination: ' + this.destinationCity.name,
                textAlign: TextAlign.left,
              ),
              Center(
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Approve',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightGreen,
                      onPressed: () async {
                        await approveForm();
                      },
                    ),
                    FlatButton(
                      child: Text('Reject'),
                      color: Colors.redAccent,
                      onPressed: () async {
                        await rejectForm();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future approveForm() async {
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/forms/approve',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'form_id': id.toString(),
      }),
    );
    return response;
  }

  Future rejectForm() async {
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/forms/reject',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'form_id': id.toString(),
      }),
    );
    return response;
  }
}
