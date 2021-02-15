import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//  Provider.of<CurrentGame>(context, listen: false)
//                         .startGame();
//                     Navigator.of(context).pushNamed(MainScreen.routeName);
class StartingScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  final myController = TextEditingController();
  String _heroName;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  getAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose your hero name"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: myController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go'),
              onPressed: () {
                Provider.of<CurrentGame>(context, listen: false)
                    .startGame(myController.text)
                    .then((value) =>
                        Navigator.of(context).pushNamed(MainScreen.routeName));
                //Navigator.of(context).pushNamed(MainScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }

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
                    getAlert(context);
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
