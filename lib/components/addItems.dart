import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController nameController = TextEditingController();
  String response = "NULL";
  createItem() async{
    var dataStr = jsonEncode({
      "command" : "add_item",
      "name" : nameController.text
    });
    var url = Uri.parse("http://192.168.234.1/flutter_add_item/index.php?data=" + dataStr);
    var result = await http.get(url);
    print("Res: $result");
   
    setState(() {   
       this.response = result.body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Column(
        children: <Widget> [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name'
            ),
          ),
          SizedBox(height: 15,),
          RaisedButton(onPressed: createItem,
          child: Text("Create"),),
          Text(this.response)
        ],
      ),
    );
  }
}