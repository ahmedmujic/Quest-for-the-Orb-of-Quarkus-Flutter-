import 'package:OrbOfQuarkus/models/items.dart';
import 'package:OrbOfQuarkus/models/monster.dart';
import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:OrbOfQuarkus/widgets/monster_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonstersScreen extends StatelessWidget {
  final bool monster;

  MonstersScreen(this.monster);

  @override
  Widget build(BuildContext context) {
    print(monster);
    List<Monster> monsters = [];
    List<Items> items = [];

    if (monster) {
      monsters = Provider.of<CurrentDungeon>(context, listen: false)
          .currentDungeon
          .monsters;
    } else if (monster == false) {
      items = Provider.of<CurrentDungeon>(context, listen: false)
          .currentDungeon
          .items;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.builder(
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: monster ? monsters.length : items.length,
        itemBuilder: (ctx, index) => MonsterInfo(
            monster ? monsters[index] : null,
            monster == false ? items[index] : null),
      ),
    );
  }
}
