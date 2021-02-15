import 'package:OrbOfQuarkus/models/items.dart';
import 'package:OrbOfQuarkus/models/weapons.dart';
import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ItemType { HealingPotion, PowerUps }

class InventoryItem extends StatelessWidget {
  final Weapon weaponChoosen;
  final Items item;
  final bool weapon;
  InventoryItem({
    this.weapon,
    this.item,
    this.weaponChoosen,
  });

  String defineImagePath() {
    return weaponChoosen.name == "Wizard M-12" && weaponChoosen != null
        ? "/hero/heroWeapon.png"
        : weaponChoosen.name == "Wizard's Fire" && weaponChoosen != null
            ? "/hero/heroWeapon2.png"
            : item is HealingPotion
                ? "/potions/potion1.png"
                : item is PowerUps
                    ? "/potions/powerUp.png"
                    : null;
  }

  healOrPowerPlayer(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              item.quantity != 0 ? "Please confirm your choice!" : "Error!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(item.quantity != 0
                    ? "Do you want to heal hero with ${item.name}?"
                    : "You dont have this item in your invenotry!"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(item.quantity != 0 ? 'Yes' : "OK"),
              onPressed: () {
                if (item.quantity != 0) {
                  if (item is HealingPotion) {
                    print("pogodio sam ga");
                    Provider.of<CurrentGame>(context)
                        .healPlayerByPlayerIdHealId(healId: item.id);
                  } else if (item is PowerUps) {
                    Provider.of<CurrentGame>(context)
                        .powerPlayerByPlayerIdPowerID(powerId: item.id);
                  }
                }

                Navigator.of(context).pop();
              },
            ),
            item.quantity != 0
                ? FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Text(""),
          ],
        );
      },
    );
  }

  primaryWeaponModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Please confirm your choice!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Do you want to set ${weaponChoosen.name} as your primary weapon?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Provider.of<CurrentGame>(context)
                    .setPrimaryWeaponId(weaponChoosen.id);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String itemDescription() {
    if (item is HealingPotion) {
      HealingPotion healingPotion = item;
      return "Healing value: ${healingPotion.healthAddition}";
    } else {
      PowerUps powerUps = item;
      return "Power ups: ${powerUps.powerValue}";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(weapon);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            weapon ? primaryWeaponModal(context) : healOrPowerPlayer(context);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  weapon
                      ? 'assets/images${defineImagePath()}'
                      : 'assets/images/potions/potion1.png',
                  scale: 5.5,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      weapon == false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  itemDescription(),
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : weapon == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      weaponChoosen.name,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Weapon health: " +
                                          weaponChoosen.health.toString(),
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              : null,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.red,
            child: Text(
              !weapon ? item.quantity.toString() : "1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ))
      ],
    );
  }
}
