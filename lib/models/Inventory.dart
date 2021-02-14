import 'package:OrbOfQuarkus/models/weapons.dart';

import 'items.dart';

class Inventory {
  final int id;
  final List<Items> items;
  final List<Weapon> weapons;
  Inventory({this.id, this.items, this.weapons});
}
