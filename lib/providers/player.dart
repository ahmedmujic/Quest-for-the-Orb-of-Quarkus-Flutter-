import 'dart:convert';

import 'package:OrbOfQuarkus/models/Inventory.dart';
import 'package:OrbOfQuarkus/models/items.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Player {
  int id;
  double health;
  double score;
  Inventory inventory;
  String name;

  Player(
      {@required this.health,
      @required this.score,
      @required this.inventory,
      @required this.name,
      @required this.id});
}

class CurrentPlayer with ChangeNotifier {
  Player currentPlayer;

  /*Future<void> getPlayerByGameId() async {
    const url = "http://10.0.2.2:8080/api/player/1";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print(extractedData);
      final Player currentPlayerResponse = Player(
          health: extractedData['health'], score: extractedData['score']);
      currentPlayer = currentPlayerResponse;
    } catch (error) {
      throw (error);
    }
  }*/
}
