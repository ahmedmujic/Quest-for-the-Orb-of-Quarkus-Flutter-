enum ItemType { powerUps, healingPotion }

class Items {
  int id;
  String name;
  int quantity;

  Items({this.id, this.name, this.quantity});
}

class HealingPotion extends Items {
  double healthAddition;

  HealingPotion({id, name, quantity, this.healthAddition})
      : super(id: id, name: name, quantity: quantity);
}

class PowerUps extends Items {
  double powerValue;

  PowerUps({id, name, quantity, this.powerValue})
      : super(id: id, name: name, quantity: quantity);
}
