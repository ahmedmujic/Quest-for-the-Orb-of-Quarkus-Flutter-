import 'package:OrbOfQuarkus/screens/inventory.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              child: Center(
                  child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.orange, fontSize: 30),
              )),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 45, 56, 68),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Inventory"),
            onTap: () {
              Navigator.of(context).pushNamed(InventoryScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
