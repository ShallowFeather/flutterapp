import 'package:count/data/LoadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:count/data/GoodsClass.dart'

String LastData = "";

class AddDataPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: Appbar(context),
      body: body(),
      drawer: Drawer(),
    );
  }

  AppBar Appbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("新增資料"),
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        icon: Icon(Icons.list_sharp),
        color: Colors.white,
        iconSize: 35,
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: IconButton(
              onPressed: () {
                Database().AddData();
                Navigator.pop(context);
              },
              icon: Icon(Icons.check_box),
              color: Colors.white,
              iconSize: 35,
            )
        )
      ],
    );
  }
}

class body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Body();
}

class Body extends State<body> {
  final TextEditingController _controller = new TextEditingController();
  String history = '';
  int firstNum = 0, secondNum = 0;
  String res = '';
  String total = '';
  String operation = '';

  void btnOnClick(String Val) {
    print(Val);
    print(total);
    if (Val == 'C') {
      total = "";
      firstNum = 0;
      secondNum = 0;
      res = "";
    } else if (Val == 'AC') {
      total = "";
      firstNum = 0;
      secondNum = 0;
      res = "";
      history = "";
    } else if(Val == '+/-'){
      if(total[0] != '-') {
        res = '-' + total;
      } else{
          res = total.substring(1);
      }
    } else if(Val == '<-') {
      res = total.substring(0, total.length - 1);
    }
    else if (Val == '+' || Val == '-' || Val == 'X' || Val == '/') {
      firstNum = int.parse(total);
      res = '';
      operation = Val;
    } else if (Val == '=') {
      secondNum = int.parse(total);
      if (operation == '+') {
        res = (firstNum + secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      } else if (operation == '-') {
        res = (firstNum - secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      } else if (operation == 'X') {
        res = (firstNum * secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      } else if (operation == '/') {
        res = (firstNum / secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      }
    } else {
      res = int.parse(total + Val).toString();
    }
    if(total.length > 10 || res.length > 10) {
      total = "";
      res = "";
    }
    setState(() {
      total = res;
      LastData = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            history,
            style: TextStyle(fontSize: 32, color: Colors.black45),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            total,
            style: TextStyle(fontSize: 60),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10, bottom: 0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "名稱",
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "備註",
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "類別",
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "新增類別",
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButtom(text: "AC", callback: btnOnClick),
                NumberButtom(text: "C", callback: btnOnClick),
                NumberButtom(text: "<-", callback: btnOnClick),
                NumberButtom(text: "/", callback: btnOnClick),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButtom(text: "7", callback: btnOnClick),
                NumberButtom(text: "8", callback: btnOnClick),
                NumberButtom(text: "9", callback: btnOnClick),
                NumberButtom(text: "X", callback: btnOnClick),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButtom(
                  text: "4",
                  callback: btnOnClick,
                ),
                NumberButtom(text: "5", callback: btnOnClick),
                NumberButtom(text: "6", callback: btnOnClick),
                NumberButtom(text: "-", callback: btnOnClick),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButtom(text: "1", callback: btnOnClick),
                NumberButtom(text: "2", callback: btnOnClick),
                NumberButtom(text: "3", callback: btnOnClick),
                NumberButtom(text: "+", callback: btnOnClick),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButtom(text: "+/-", callback: btnOnClick),
                NumberButtom(text: "0", callback: btnOnClick),
                NumberButtom(text: "00", callback: btnOnClick),
                NumberButtom(text: "=", callback: btnOnClick),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class NumberButtom extends StatelessWidget {
  final String text;
  final Function callback;

  const NumberButtom({
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5),
      child: SizedBox(
          width: 85,
          height: 45,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            onPressed: () => callback(text),
            color: Colors.black,
          )),
    );
  }
}
/*
class TypeList extends StatefulWidget {
  @override
  State<TypeList> createState() => _TypeList();
}

class _TypeList extends State<TypeList> {
  List<DropdownMenuItem<String>> sortItems = [];
  String _selectedSort = '排序';

  sortItems.add(DropdownMenuItem(value: '排序', child: Text('排序')));
  sortItems.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
  sortItems.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getList());
  }

  getList() {
    return DropdownButton(
      value: _selectedSort,
      items: sortItems,
      onChanged: changedSort,
    );
  }
}
*/