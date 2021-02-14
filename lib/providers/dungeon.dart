import 'dart:convert';

import 'package:OrbOfQuarkus/models/items.dart';
import 'package:OrbOfQuarkus/models/monster.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Dungeon {
  int id;
  List<Monster> monsters;
  List<Items> items;

  Dungeon({this.id, this.monsters, this.items});
}

Map<String, String> customHeaders = {"content-type": "application/json"};

class CurrentDungeon with ChangeNotifier {
  Dungeon currentDungeon;

  Future<void> nextDungeon() async {
    const url = "http://10.0.2.2:8080/api/game/1/move";

    try {
      final response = await http.post(url, headers: customHeaders);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      print(extractedData);
      List<Monster> responseMonsters = [];

      extractedData['monsters'].forEach((monster) {
        responseMonsters.add(Monster(
            id: monster["id"],
            alive: monster["alive"],
            damage: monster["damage"],
            health: monster["health"],
            name: monster["name"]));
      });
      List<Items> itemsResult = [];
      extractedData["items"].forEach((element) {
        itemsResult.add(HealingPotion(
            healthAddition: element['healingPotion']['healthAddition'],
            id: element['healingPotion']['id'],
            name: element['healingPotion']['name'],
            quantity: 1));
      });

      final Dungeon currentDungeon = Dungeon(
          id: extractedData["dungeonId"],
          items: itemsResult,
          monsters: responseMonsters);

      this.currentDungeon = currentDungeon;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
