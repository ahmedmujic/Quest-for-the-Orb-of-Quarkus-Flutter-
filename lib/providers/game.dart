import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Game {
  final int id;
  final String mapName;

  Game(this.id, this.mapName);
}

Map<String, String> customHeaders = {"content-type": "application/json"};

class CurrentGame with ChangeNotifier {
  Game currentGame;

  Future<void> startGame() async {
    const url = "http://10.0.2.2:8080/api/game";

    try {
      print("uslo");
      final response = await http.post(url,
          headers: customHeaders, body: json.encode({'name': 'Ahmed'}));
      print("uslo2");

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print("uslo3");
      final Game fetchedGame =
          Game(extractedData["gameId"], extractedData["mapName"]);
      this.currentGame = fetchedGame;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
