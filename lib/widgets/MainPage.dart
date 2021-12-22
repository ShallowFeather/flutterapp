import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:count/widgets/chart.dart';
import 'package:count/widgets/appbar.dart';

class MainPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: TopAppbar(),
      body: Column(
        children: [
            BackChart(),
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
            )
          ],
        ),
      ),
    );
  }

  AppBar TopAppbar() {
    return AppBar(
      centerTitle: true,
      title: Text("現存餘額: 1500"),
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(onPressed: () =>
        _scaffoldKey.currentState!.openDrawer(),
        icon: Icon(Icons.list_sharp),
        color: Colors.white,
        iconSize: 35,
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_box),
              color: Colors.white,
              iconSize: 35,
            )
        )
      ],
    );
  }
}
