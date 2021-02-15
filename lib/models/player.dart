import 'package:OrbOfQuarkus/models/Inventory.dart';

import 'package:flutter/foundation.dart';

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
