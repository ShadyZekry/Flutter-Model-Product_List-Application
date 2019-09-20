import 'package:flutter/material.dart';

import '../ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';

class ProductPage extends StatelessWidget {
  final int index;
  ProductPage(this.index);

  Widget _buildAddressAndPrice(String address, double price) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "$address  |  \$$price",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Oswald",
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text("Delete"),
        textColor: Colors.white,
        onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => _buildDeleteDialogue(context),
            ),
      ),
    );
  }

  Widget _buildDeleteDialogue(BuildContext context) {
    return AlertDialog(
      title: Text("Are You Sure"),
      content: Text("This action is perminent"),
      actions: <Widget>[
        FlatButton(
          child: Text("DELETE"),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: Text("Discard"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(title: Text(model.products[index].title)),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.network(model.products[index].image),
                SizedBox(height: 10.0),
                TitleDefault(model.products[index].title),
                _buildAddressAndPrice(
                    model.products[index].address, model.products[index].price),
                Text(model.products[index].details),
                _buildDeleteButton(context),
              ],
            ),
          ],
        ),
      );
    });
  }
}
