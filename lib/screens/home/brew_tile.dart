import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brewItem;

  BrewTile({ required this.brewItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown[brewItem.strength],
                backgroundImage: const AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(brewItem.name),
            subtitle: Text('Takes ${brewItem.sugars} sugar(s)'),
          ),
        ),
    );
  }
}