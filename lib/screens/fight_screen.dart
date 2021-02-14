import 'dart:async';
import 'dart:io';

import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FightScreen extends StatefulWidget {
  static const routeName = "/fight";

  @override
  _FightScreenState createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen> {
  int _monsterIndex = 0;
  String _enemyStatus = 'monsterIdle1';
  String _heroStatus = "heroIdle";
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void toggleAnimations() async {
    setState(
        () => {_enemyStatus = "monsterAttack1", _heroStatus = "heroAttack"});

    setState(() {
      _enemyStatus = "monsterDying1";
      _heroStatus = "heroIdle";
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _enemyStatus = "monsterIdle1";
      _heroStatus = "heroIdle";
    });
  }

  void fightWithMonster(BuildContext context, int monsterId) async {
    if (_monsterIndex ==
        (Provider.of<CurrentDungeon>(context).currentDungeon.monsters.length -
            1)) {
      Provider.of<CurrentDungeon>(context).nextDungeon();
      setState(
          () => {_enemyStatus = "monsterAttack1", _heroStatus = "heroAttack"});

      await Future.delayed(Duration(seconds: 4));

      getAlert("Good job! You killed all monsters",
          "Are you ready for the next fight");

      setState(() {
        _enemyStatus = "monsterDying1";
        _heroStatus = "heroIdle";
      });

      setState(() {
        _monsterIndex = 0;
      });
    }
    setState(
        () => {_enemyStatus = "monsterAttack1", _heroStatus = "heroAttack"});

    Provider.of<CurrentGame>(context)
        .fightWithMonsterByMonsterIdWeaponId(monsterId: monsterId);
    setState(() {
      this._monsterIndex++;
    });

    await Future.delayed(Duration(seconds: 4));

    if (Provider.of<CurrentGame>(context).endGame == false) {
      setState(
          () => {_enemyStatus = "monsterAttack1", _heroStatus = "heroAttack"});

      setState(() {
        _enemyStatus = "monsterDying1";
        _heroStatus = "heroIdle";
      });

      await Future.delayed(Duration(milliseconds: 1120));

      setState(() {
        _enemyStatus = "monsterIdle1";
        _heroStatus = "heroIdle";
      });

      setState(() {
        _visible = !_visible;
      });
    }
  }

  getAlert(String dialogTitle, String dialogText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialogText),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pushNamed(MainScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Dungeon _currentDungeon =
        Provider.of<CurrentDungeon>(context).currentDungeon;
    Game _currentGame = Provider.of<CurrentGame>(context).currentGame;
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
      body: Stack(
        children: [
          Center(
            child: Text("kskaskd"),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5,
            top: 20,
            child: AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Text(
                "Enemy $_monsterIndex is ready!\nGood luck",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/dungeons/dungeon${_currentDungeon.id}.png'),
                    fit: BoxFit.cover)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/hero/$_heroStatus.gif',
                  scale: 2.5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      child: InkWell(
                        onTap: () {
                          fightWithMonster(context,
                              _currentDungeon.monsters[_monsterIndex].id);
                          //toggleAnimations();
                        },
                        child: Image.asset(
                          'assets/images/monsters/$_enemyStatus.gif',
                          scale: 2.5,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 20,
              child: Chip(
                backgroundColor: Colors.orange,
                avatar: Icon(
                  Icons.sports_motorsports_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  (_currentDungeon.monsters.length - _monsterIndex).toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              top: 10,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    backgroundColor: Colors.green,
                    avatar: Icon(
                      Icons.local_florist_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      _currentGame.player.health.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Chip(
                    backgroundColor: Colors.green,
                    avatar: Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    label: Text(
                      _currentGame.player.score.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
