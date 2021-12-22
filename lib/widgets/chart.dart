import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class BackChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
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
                    )
                )
              ),
              Positioned(
                child: Chart(),
              ),
            ],
          ),
        )
      ]
    );
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
        width: ,
        child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SfCircularChart(
                legend: Legend(isVisible: true, backgroundColor: Colors.white),
                series: <CircularSeries>[
                  PieSeries<TotalData, String>(
                    dataSource: _chartData,
                    xValueMapper: (TotalData data, _) => data.continent,
                    yValueMapper: (TotalData data, _) => data.cost,
                  )
                ],backgroundColor: Colors.transparent,),
            )
          )
    );
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
