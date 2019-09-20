import 'package:flutter/material.dart';
import './pages/auth.dart';
import './pages/home.dart';
import './pages/manage.dart';
import './pages/product.dart';

import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main_model.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MainModel model = MainModel();

  Widget build(conext) {
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
        ),
        //home: AuthPage(),

        routes: {
          "/": (context) => AuthPage(),
          "/home": (context) => HomePage(model),
          "/admin": (context) => ManagePage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split("/");

          if (pathElements[0] != "") return null;

          if (pathElements[1] == "product") {
            int index = int.parse(pathElements[2]);

            return MaterialPageRoute<bool>(
              builder: (context) => ProductPage(index),
            );
          }

          return null;
        },

        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => HomePage(model));
        },
      ),
    );
  }
}
