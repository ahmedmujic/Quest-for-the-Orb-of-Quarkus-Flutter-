import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/widgets/AppDrawer.dart';
import 'package:OrbOfQuarkus/widgets/mission_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main-screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      // Provider.of<Player.CurrentPlayer>(context, listen: false)
      //     .getPlayerByGameId()
      //     .then((value) => setState(() {
      //           _isLoading = false;
      //         }));

      Provider.of<CurrentDungeon>(context, listen: false)
          .nextDungeon()
          .then((value) => setState(() {
                _isLoading = false;
              }));

      _isInit = false;
      super.didChangeDependencies();
    }
  }

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
    final currentPlayer = _isLoading
        ? null
        : Provider.of<CurrentGame>(context).currentGame.player;
    final currentGame = Provider.of<CurrentGame>(context).currentGame;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 47, 64),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                            statsChip(
                                score: currentPlayer.score.toString(),
                                icon: Icons.military_tech_sharp),
                            statsChip(
                                score: currentPlayer.health.toString(),
                                icon: Icons.local_florist_rounded),
                            statsChip(
                                score: currentGame.mapName,
                                icon: Icons.map_outlined)
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
                                    currentPlayer.name,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Mission progress",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 300,
                        child: Center(
                          child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            itemCount: 10,
                            itemBuilder: (ctx, index) {
                              return MissionChooser(index + 1);
                            },
                          ),
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
