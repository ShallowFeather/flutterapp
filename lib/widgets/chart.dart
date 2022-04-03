import 'package:count/data/LoadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/GoodsClass.dart';

class BackChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Container(
        height: size.height * 0.4,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Chart(),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(72),
                      bottomRight: Radius.circular(72),
                    ))),
            Container(
              alignment: Alignment.center,
              width: 500,
              height: 225,
              child: Chart(),
            ),
            Positioned(
                bottom: 10,
                right: 75,
                left: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.calendar_today),
                      color: Colors.white,
                    ),
                    Text(
                      "現存餘額: 1500",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.zero,
                      onPressed: () {

                      },
                      icon: Icon(Icons.apps),
                      color: Colors.white,
                    )
                  ]
                )
            )
          ],
        ),
      )
    ]);
  }
}

class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Chart();
}

class _Chart extends State<Chart> {
  late List<TotalData> _chartData;
  Map mapOfAll = new Map<String, int>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_){
      _asyncMethod();
    });

  }
  _asyncMethod() async {
    _chartData = await getChartData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UseDatabase.instance.readAllitems(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (ConnectionState.active != null && !snapshot.hasData) {
          return Container();
        }
        if (ConnectionState.done != null && snapshot.hasError) {
          return Center();
        }
        num AllCost = 0;
        Map mapOfAll = new Map<String, int>();
        for (var i = 0; i < snapshot.data.length; i++) {
          if(mapOfAll[snapshot.data[i].name] == null) {
            mapOfAll[snapshot.data[i].name] = 0;
          }
          mapOfAll[snapshot.data[i].name] = mapOfAll[snapshot.data[i].name] + snapshot.data[i].cost;
          print(mapOfAll[snapshot.data[i].name]);
        }
        return Container(
            child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SfCircularChart(
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Container(
                            color: Colors.transparent,
                            child: PhysicalModel(
                              color: Colors.transparent,
                              child: Text(
                                AllCost.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                      legend: Legend(
                          isVisible: true,
                          backgroundColor: Colors.transparent,
                          textStyle: TextStyle(color: Colors.white)),
                      series: <CircularSeries>[
                        DoughnutSeries<TotalData, String>(
                          dataSource: _chartData,
                          xValueMapper: (TotalData data, _) => data.continent,
                          yValueMapper: (TotalData data, _) => data.cost,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(color: Colors.white)),
                        )
                      ]),
                )));
      },
    );
  }
  Future<List<TotalData>> getChartData() async {
    List<TotalData> ret = [];
    List<LastGoods> getList =  await UseDatabase.instance.readAllitems();
    Map mapOfAll = new Map<String, int>();
    for (var i = 0; i < getList.length; i++) {
      if(mapOfAll[getList[i].name] == null) {
        mapOfAll[getList[i].name] = 0;
      }
      mapOfAll[getList[i].name] = mapOfAll[getList[i].name] + getList[i].cost;
    }
    mapOfAll.forEach((key, value) {
      ret.add(TotalData(key, value));
    });
    return ret;
  }
}

class TotalData {
  TotalData(this.continent, this.cost);

  final String continent;
  final int cost;
}
