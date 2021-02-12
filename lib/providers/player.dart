import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Player with ChangeNotifier {
  final double health;
  final double score;

  Player({@required this.health, @required this.score});

  Future<void> getPlayer() async {
    const url = "http://10.0.2.2:8080/api/game";
  }
}
