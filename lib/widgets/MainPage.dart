import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Cash"),
        backgroundColor: Colors.yellow,
        centerTitle: false,
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
    );
  }
  ekotlinasdsads