import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';
import './product_card.dart';

class Products extends StatelessWidget {
  Widget _buildProducts(int length) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => ProductCard(index),
      itemCount: length,
    );
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.products.isEmpty
          ? Center(child: Text("Empty Poducts"))
          : _buildProducts(model.products.length);
    });
  }
}
