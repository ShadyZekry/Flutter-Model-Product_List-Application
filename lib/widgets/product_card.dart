import 'package:flutter/material.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_tag.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';

class ProductCard extends StatelessWidget {
  final int index;
  ProductCard(this.index);

  Widget _buildButtonBar(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildProductIconButton(context, model),
          IconButton(
            icon: Icon(model.products[index].isFavourite
                ? Icons.favorite
                : Icons.favorite_border),
            color: Colors.red,
            onPressed: () => model.togleFavouriteStatus(index),
          )
        ],
      );
    });
  }

  Widget _buildProductIconButton(BuildContext context, MainModel model) {
    return IconButton(
      icon: Icon(Icons.info),
      color: Theme.of(context).accentColor,
      iconSize: 30,
      onPressed: () => Navigator.pushNamed<bool>(
            context,
            "/product/" + index.toString(),
          ).then((bool value) {
            if (value == true) model.deleteProduct(index);
          }),
    );
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: Column(
          children: <Widget>[
            Image.network(model.products[index].image),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleDefault(model.products[index].title),
                  SizedBox(width: 6.0),
                  PriceTag(model.products[index].price)
                ],
              ),
            ),
            AddressTag("Alf Maskan, Cairo, Egypt"),
            Text(model.products[index].userEmail),
            _buildButtonBar(context),
          ],
        ),
      );
    });
  }
}
