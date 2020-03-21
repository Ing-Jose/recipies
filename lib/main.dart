import 'package:flutter/material.dart';

import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:cooking_at_home/src/pages/add_plato_page.dart';
import 'package:cooking_at_home/src/pages/detalles_plato_page.dart';
import 'package:cooking_at_home/src/pages/home_page.dart';
import 'package:cooking_at_home/src/pages/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
          child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: HomePage.namePage,
      routes: <String, WidgetBuilder>{
        HomePage.namePage: (BuildContext context) => HomePage(),
        AddPlatoPage.namePage: (BuildContext context) => AddPlatoPage(),
        DetallesPlatoPage.namePage: (BuildContext context) =>DetallesPlatoPage(),
        SearchPage.namePage: (BuildContext context) => SearchPage(),
      }
        ),
    );
  }
}
