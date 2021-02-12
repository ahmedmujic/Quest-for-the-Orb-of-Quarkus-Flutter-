import 'package:OrbOfQuarkus/providers/game.dart';
import 'package:OrbOfQuarkus/screens/inventory.dart';
import 'package:OrbOfQuarkus/screens/main_screen.dart';
import 'package:OrbOfQuarkus/screens/starting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CurrentGame())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartingScreen(),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          InventoryScreen.routeName: (ctx) => InventoryScreen()
        },
      ),
    );
  }
}
