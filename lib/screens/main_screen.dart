import 'package:OrbOfQuarkus/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/main-screen";

  Widget statsChip({String score, IconData icon}) {
    return Chip(
      padding: EdgeInsets.all(1),
      label: Text(
        score,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color.fromARGB(255, 45, 56, 68),
      avatar: CircleAvatar(
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: AppDrawer(),
      body: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                color: Color.fromARGB(255, 34, 43, 54),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      statsChip(score: "2000", icon: Icons.military_tech_sharp),
                      statsChip(
                          score: "100", icon: Icons.local_florist_rounded),
                      statsChip(score: "Sytherin", icon: Icons.map_outlined)
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/hero.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Ahmed Mujic",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Mission progress",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/images/forest1.png"))),
                      ),
                      Positioned(
                          bottom: 20,
                          left: 10,
                          child: Text(
                            "Ovo je pozicionirani tekst",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
