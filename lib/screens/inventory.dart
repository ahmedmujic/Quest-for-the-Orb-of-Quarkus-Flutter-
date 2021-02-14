import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/widgets/inventory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatelessWidget {
  static const routeName = "/inventory";

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    final inventory =
        Provider.of<CurrentGame>(context).currentGame.player.inventory;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 43, 54),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          "Orb of Quarkus",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Color.fromARGB(255, 45, 56, 68),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Items",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height) /
                3,
            child: inventory.items.length == 0
                ? Center(
                    child: Text(
                      "There are not items",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                : GridView(
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    children: inventory.items
                        .map((e) => InventoryItem(
                              weapon: false,
                              item: e,
                            ))
                        .toList(),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Weapons",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height) /
                3,
            child: GridView(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: inventory.weapons
                  .map((e) => InventoryItem(
                        weapon: true,
                        weaponChoosen: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );

    // body: Container(
    //   height: MediaQuery.of(context).size.height,
    //   width: double.infinity,
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 100),
    //     child: Container(
    //       color: Colors.red,
    //       height: 300,
    //       child: Container(
    //         width: MediaQuery.of(context).size.width * 0.5,
    //         child: Card(
    //           child: Column(
    //             children: [Text("Neki tekst")],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ),
  }
}
