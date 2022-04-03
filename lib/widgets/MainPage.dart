import 'package:count/data/GoodsClass.dart';
import 'package:count/data/LoadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:count/widgets/chart.dart';
import 'package:count/widgets/List.dart';
import 'package:count/widgets/AddData.dart';
import 'package:path/path.dart';


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
          Expanded(
            child: LastBuyList(),
          ),
        ]
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
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
  Widget LastBuyList() {
    return FutureBuilder(
      future: UseDatabase.instance.readAllitems(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (ConnectionState.active != null && !snap.hasData) {
          return Container();
        }
        if (ConnectionState.done != null && snap.hasError) {
          return Center();
        }
        return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snap.data[index].name,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snap.data[index].date.toString(),
                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                        ]
                      ),
                      Text(
                        "\$" + snap.data[index].cost.toString(),
                        style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                )
              );
              //Text(snap.data[index].name);
            },
        );
        },
    );
  }
}


