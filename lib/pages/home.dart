import 'package:flutter/material.dart';
import '../widgets/products.dart';
import '../scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  final MainModel _model;
  HomePage(this._model);

  Widget _buildProductList(MainModel model) {
    return FutureBuilder(
      future: _model.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Products();
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
    //return model.products.isEmpty ? Text("loading") : Products(model);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Side Drawer"),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage"),
              onTap: () => Navigator.pushNamed(context, "/admin"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () => Navigator.pushReplacementNamed(context, "/"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Main Products!!!"),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: model.favouriteFilter
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () => model.toggleFavouriteFilter(),
            );
          })
        ],
      ),
      body: _buildProductList(_model),
    );
  }
}
