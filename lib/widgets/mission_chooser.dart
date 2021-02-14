import 'package:OrbOfQuarkus/providers/dungeon.dart';
import 'package:OrbOfQuarkus/screens/prefight_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissionChooser extends StatelessWidget {
  final int dungeonIndex;

  MissionChooser(this.dungeonIndex);
  Widget dungeonInformation({String quantity, IconData icon}) {
    return Chip(
      padding: EdgeInsets.all(1),
      label: Container(
        child: Text(
          quantity,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 45, 56, 68),
      avatar: CircleAvatar(
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(dungeonIndex);
    final dungeon =
        Provider.of<CurrentDungeon>(context, listen: false).currentDungeon;
    return InkWell(
      onTap: () {
        dungeonIndex == dungeon.id
            ? Navigator.of(context).pushNamed(PrefightScreen.routeName)
            : null;
      },
      child: Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: dungeonIndex != dungeon.id
                    ? ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.black54, BlendMode.darken),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/dungeons/dungeon$dungeonIndex.png"))),
                        ),
                      )
                    : ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.black87, BlendMode.lighten),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/dungeons/dungeon$dungeonIndex.png"))),
                        ),
                      ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dungeon $dungeonIndex",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      dungeonIndex == dungeon.id
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dungeonInformation(
                                    quantity:
                                        dungeon.monsters.length.toString(),
                                    icon: Icons.motion_photos_paused_sharp),
                                dungeonInformation(
                                    quantity: dungeon.items.length.toString(),
                                    icon: Icons.card_travel),
                              ],
                            )
                          : Text("")
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
