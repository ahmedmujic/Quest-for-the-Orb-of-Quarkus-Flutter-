import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/homeScreen.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 200, bottom: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orb of Quarkus",
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.blue,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    color: Color.fromARGB(255, 252, 147, 61),
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MainScreen.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "START",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
