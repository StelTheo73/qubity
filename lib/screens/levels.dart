import 'package:flutter/material.dart';

import '../components/navbar/navbar.dart';
import '../constants/routes.dart';
import '../utils/level.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  LevelsScreenState createState() => LevelsScreenState();
}

class LevelsScreenState extends State<LevelsScreen> {
  late Future<List<dynamic>> levelsFuture;

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  void _loadLevels() {
    setState(() {
      levelsFuture = LevelLoader.loadLevels();
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<dynamic>>(
  //     future: levelsFuture,
  //     builder: (
  //       BuildContext context,
  //       AsyncSnapshot<List<dynamic>> snapshot,
  //     ) {
  //       if (snapshot.hasData) {
  //         return Column(
  //           children: <Widget>[
  //             Expanded(
  //               child: GridView.builder(
  //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2,
  //                   crossAxisSpacing: 5.0,
  //                 ),
  //                 itemCount: snapshot.data!.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return Card(
  //                     // margin: const EdgeInsets.all(40),
  //                     margin: const EdgeInsets.only(
  //                       left: 20,
  //                       right: 20,
  //                       top: 40,
  //                       bottom: 40,
  //                     ),
  //                     color: Colors.orange,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         children: [
  //                           Text(
  //                             'Level ${index + 1}',
  //                             style: const TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 10.0),
  //                           Text(
  //                             snapshot.data![index]['description'] as String,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         );
  //       }
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Levels'),
      body: FutureBuilder<List<dynamic>>(
        future: levelsFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.all(40),
                        color: Colors.orange,
                        shadowColor: Colors.black,
                        elevation: 5.0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.game.route,
                              arguments: snapshot.data![index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  child: Text(
                                    'Level ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  snapshot.data![index]['description']
                                      as String,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
