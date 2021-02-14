import 'dart:math';

import 'package:OrbOfQuarkus/models/items.dart';
import 'package:OrbOfQuarkus/models/monster.dart';
import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonsterInfo extends StatelessWidget {
  final Monster monster;
  final HealingPotion item;
  MonsterInfo(this.monster, this.item);

  int randomNumber(int starting, int ending) {
    Random random = new Random();
    return random.nextInt(ending) + starting;
  }

  @override
  Widget build(BuildContext context) {
    if (item != null) print("sakdskk" + item.name);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          monster != null
              ? Image.asset('assets/images/monsters/monsterIdle1.gif')
              : Image.asset(
                  'assets/images/potions/potion1.png',
                  scale: 1.5,
                ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              monster != null ? monster.name : item.name,
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              monster != null ? "Damage" : "Health addition",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              backgroundColor: Colors.red,
              value: monster != null
                  ? monster.damage / 100
                  : item.healthAddition / 100,
            ),
          ),
          monster != null
              ? Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Health",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              : Text(""),
          monster != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                    value: monster.health / 100,
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
