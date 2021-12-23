import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:count/widgets/chart.dart';
import 'package:count/widgets/List.dart';
import 'package:count/widgets/AddData.dart';


class MainPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: TopAppbar(context),
      body: Column(
        children: [
          BackChart(),
          //LastBuyList(),
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

  AppBar TopAppbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("本月收支"),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDataPage()),
                );
              },
              icon: Icon(Icons.add_box),
              color: Colors.white,
              iconSize: 35,
            )
        )
      ],
    );
  }
}
