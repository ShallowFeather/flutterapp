import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                      onPressed: () {},
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

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    '20990',
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
                  isVisible: true, textStyle: TextStyle(color: Colors.white)),
            )
          ]),
    )));
  }

  List<TotalData> getChartData() {
    final List<TotalData> chartData = [
      TotalData("Food", 1500),
      TotalData("Learn", 3500),
      TotalData("House", 10000),
      TotalData("Gift", 1000),
      TotalData("Car", 4000),
      TotalData("Pet", 990),
    ];
    return chartData;
  }
}

class TotalData {
  TotalData(this.continent, this.cost);

  final String continent;
  final int cost;
}
