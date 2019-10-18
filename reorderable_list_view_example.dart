import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Firebase',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  final cloudFirestore = Firestore.instance;
  List<int> items = [];
  List<dynamic> programItems = [];

  bool programItemsLoaded = false;

  Future getProgramsItems() async {
    programItems = json.decode(
        '[{"documentID": "001_ABC", "program_item_title": "Activity"}, {"documentID": "002_ABC", "program_item_title": "Connect with Others"}, {"documentID": "003_ABC", "program_item_title": "Bible Story"}, {"documentID": "004_ABC", "program_item_title": "Discussion"}, {"documentID": "005_ABC", "program_item_title": "Prayer"}, {"documentID": "006_ABC", "program_item_title": "Welcome"}]');

    makeTiles();

    this.setState(() {
      programItemsLoaded = true;
    });

    return programItems;
  }

  makeTiles() {
    items = [];

    for (int i = 0; i < programItems.length; i++) {
      items.add(i);
//      var item = programItems[i];
//
//      print(i.toString() + " " + item["documentID"]);
//
//      ListTile tile = ListTile(
//        key: Key(item["documentID"]),
//        title: Text(item["program_item_title"]),
//      );
//
//      tiles.add(tile);
    }
  }

  ListTile makeTile(int index) {
    var item = programItems[index];
    return ListTile(
      key: Key(item["documentID"]),
      title: Text(item["program_item_title"]),
    );
  }

  onReorder(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      final int item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  void initState() {
    super.initState();
    getProgramsItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: programItemsLoaded == false
          ? Container(
              child: Center(
                child: Text("Loading..."),
              ),
            )
          : ReorderableListView(
              children: items.map(makeTile).toList(),
              onReorder: (oldIndex, newIndex) {
                onReorder(oldIndex, newIndex);
              },
            ),
    );
  }
}
