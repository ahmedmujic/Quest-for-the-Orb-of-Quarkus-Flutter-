import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  static const routeName = "/inventory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 43, 54),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          "Orb of Quarkus",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            color: Colors.red,
            height: 300,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Card(
                child: Column(
                  children: [Text("Neki tekst")],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
