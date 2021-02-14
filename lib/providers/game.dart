import 'dart:convert';

import 'package:OrbOfQuarkus/models/Inventory.dart';
import 'package:OrbOfQuarkus/models/items.dart';
import 'package:OrbOfQuarkus/models/weapons.dart';
import 'package:OrbOfQuarkus/providers/player.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Game {
  int id;
  String mapName;
  Player player;
  Game({this.id, this.mapName, this.player});
}

Map<String, String> customHeaders = {"content-type": "application/json"};

class CurrentGame with ChangeNotifier {
  Game currentGame;
  int primaryWeaponId;
  bool endGame = false;

  setPrimaryWeaponId(int weaponId) {
    this.primaryWeaponId = weaponId;
    print(this.primaryWeaponId);
    notifyListeners();
  }

  Future<void> healPlayerByPlayerIdHealId({int healId}) async {
    var url =
        "http://10.0.2.2:8080/api/player/${currentGame.player.id}/heal/$healId";
    try {
      final response = await http.post(
        url,
        headers: customHeaders,
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      currentGame.player.health = extractedData["health"];
      getPlayerByGameId();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> powerPlayerByPlayerIdPowerID({int powerId}) async {
    var url =
        "http://10.0.2.2:8080/api/player/${currentGame.player.id}/power-up/$powerId";
    try {
      final response = await http.post(
        url,
        headers: customHeaders,
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      getPlayerByGameId();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> fightWithMonsterByMonsterIdWeaponId({int monsterId}) async {
    print(currentGame.id);
    var url = "http://10.0.2.2:8080/api/game/${currentGame.id}/fight";
    try {
      final response = await http.post(url,
          headers: customHeaders,
          body: json
              .encode({'monsterID': monsterId, "weaponID": primaryWeaponId}));

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final bool win = extractedData["win"];
      if (win) {
        print("uslo je u pobjedu");
        getPlayerByGameId();
      } else if (win == false) {
        this.endGame = true;
        throw ("kraj igre");
      }
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> getPlayerByGameId() async {
    var url = "http://10.0.2.2:8080/api/player/${currentGame.id}";
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print("uslo je u igrace prije items resulta");
      List<Items> itemsResult = [];
      extractedData["playerInventory"]["items"].forEach((element) {
        if (element['healingPotion'] != null) {
          itemsResult.add(HealingPotion(
              healthAddition: element['healingPotion']['healthAddition'],
              id: element['healingPotion']['id'],
              name: element['healingPotion']['name'],
              quantity: element['quantity']));
        } else {
          itemsResult.add(PowerUps(
              powerValue: element['powerUps']['powerValue'],
              id: element['powerUps']['id'],
              name: element['powerUps']['name'],
              quantity: element['quantity']));
        }
      });
      print("uslo je u igrace prije weapons resulta");
      List<Weapon> weaponsResult = [];
      extractedData["playerInventory"]["weapons"].forEach((element) {
        weaponsResult.add(Weapon(
            id: element['id'],
            damage: element['damage'],
            health: element['weaponHealth'],
            name: element['weaponName']));
      });
      print("uslo je u igrace prije weapons resulta");
      final Inventory fetchedInventory = Inventory(
          id: extractedData["playerInventory"]["id"],
          items: itemsResult,
          weapons: weaponsResult);
      print("uslo je u igrace prije response player");
      final Player reponsePlayer = Player(
          id: currentGame.player.id,
          health: extractedData["health"],
          score: extractedData["score"],
          name: this.currentGame.player.name,
          inventory: fetchedInventory);

      this.currentGame.player = reponsePlayer;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> startGame(String heroName) async {
    const url = "http://10.0.2.2:8080/api/game";

    try {
      print("uslo");
      final response = await http.post(url,
          headers: customHeaders, body: json.encode({'name': heroName}));
      print("uslo2");

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print("uslo3");

      print(extractedData);

      List<Items> itemsResult = [];
      extractedData["player"]["playerInventory"]["items"].forEach((element) {
        if (element['healingPotion'] != null) {
          itemsResult.add(HealingPotion(
              healthAddition: element['healingPotion']['healthAddition'],
              id: element['healingPotion']['id'],
              name: element['healingPotion']['name'],
              quantity: element['quantity']));
        } else {
          itemsResult.add(PowerUps(
              powerValue: element['powerUps']['powerValue'],
              id: element['powerUps']['id'],
              name: element['powerUps']['name'],
              quantity: element['quantity']));
        }
      });

      List<Weapon> weaponsResult = [];
      extractedData["player"]["playerInventory"]["weapons"].forEach((element) {
        weaponsResult.add(Weapon(
            id: element['id'],
            damage: element['damage'],
            health: element['weaponHealth'].toInt(),
            name: element['weaponName']));
      });

      final Inventory fetchedInventory = Inventory(
          id: extractedData["player"]["playerInventory"]["id"],
          items: itemsResult,
          weapons: weaponsResult);

      final Player fetchedPlayer = Player(
          id: extractedData["player"]["id"],
          name: extractedData["player"]["name"],
          health: extractedData["player"]["health"],
          score: extractedData["player"]["score"],
          inventory: fetchedInventory);

      final Game fetchedGame = Game(
          id: extractedData["gameId"],
          mapName: extractedData["mapName"],
          player: fetchedPlayer);
      this.currentGame = fetchedGame;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
