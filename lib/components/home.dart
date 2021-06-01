// import 'dart:js';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_add_item/components/addItems.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return AddItem();
          }));
        },
      ),
      body: Column(
        children: <Widget> [
          FlatButton(onPressed: refreshData,
           child: Column(
             children: <Widget> [
               Icon(Icons.refresh),
               Text("Refresh")
             ],
           ),
          ),
          Column(
            children: data.map((item) => Text(item.name)).toList(),
          )
        ],
      ),
    );
  }

  refreshData() async{
    var dataStr = jsonEncode({
      "command" : "get_items"
    });
    var url = Uri.parse("http://192.168.234.1/flutter_add_item/index.php?data=" + dataStr);
    var result = await http.get(url);
    
    setState(() {
      data.clear();
      var jsonItems = jsonDecode(result.body) as List<dynamic>;
      jsonItems.forEach((item){
        this.data.add(Item(
          item['id'] as String,
          item['name'] as String,
          DateTime.parse(item['timestamp'] as String)
        ));
      });
    });
  }
}

class Item{
  String id;
  String name;
  DateTime timestamp;

  Item(
    this.id,
    this.name,
    this.timestamp
  );
}