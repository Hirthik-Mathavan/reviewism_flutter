import 'package:flutter/material.dart';
import 'package:reviewismflutter/screens/comics_screen.dart';
import 'package:reviewismflutter/screens/new_releases.dart';
import 'package:reviewismflutter/screens/search_screen.dart';
import 'package:reviewismflutter/screens/best_sellers.dart';

void main() => runApp(MyAp());

class MyAp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      initialRoute: SearchScreen.id,
      routes: {
        SearchScreen.id: (context) => SearchScreen(),
        BestSellers.id: (context) => BestSellers(),
        NewReleases.id: (context) => NewReleases(),
        Comics.id: (context) => Comics(),
      },
    );
  }
}
