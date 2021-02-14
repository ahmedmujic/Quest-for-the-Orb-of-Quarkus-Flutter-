import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:OrbOfQuarkus/screens/fight_screen.dart';
import 'package:OrbOfQuarkus/screens/monsters_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrefightScreen extends StatefulWidget {
  static const routeName = "/prefight-screen";

  @override
  _PrefightScreenState createState() => _PrefightScreenState();
}

class _PrefightScreenState extends State<PrefightScreen> {
  List<Map<String, Object>> _pages;

  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': MonstersScreen(true), 'title': 'Monsters'},
      {'page': MonstersScreen(false), 'title': 'Items'}
    ];
  }

  void selectPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 43, 54),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          "Orb of Quarkus",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future:
            Provider.of<CurrentDungeon>(context, listen: false).nextDungeon(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text("Error occured"),
              );
            } else {
              return _pages[_selectedIndex]['page'];
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Colors.orange,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(Icons.dangerous),
              title: Text("Monsters")),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(Icons.emoji_nature),
              title: Text("Items"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.run_circle),
        onPressed: () {
          Navigator.of(context).pushNamed(FightScreen.routeName);
        },
      ),
    );
  }
}
