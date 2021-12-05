import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {

    final brew = Provider.of<List<Brew>>(context);

    // if (brew != null){
    //   brew.forEach((brewItem) {
    //     print(brewItem.name);
    //     print(brewItem.sugars);
    //     print(brewItem.strength);
    //   });
    // }

    return ListView.builder(
      itemCount: brew.length,
      itemBuilder: (context, index) {
        return BrewTile(brewItem: brew[index]);
      },
    );
  }
}

