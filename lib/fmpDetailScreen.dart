import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/city.dart';

class FmpDetailScreen extends StatelessWidget {
  final int id;
  final City city;

  FmpDetailScreen({@required this.id, @required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Id: ' + this.id.toString()),
            Text('City departure: ' + this.city.name),
          ],
        ),
      ),
    );
  }
}
