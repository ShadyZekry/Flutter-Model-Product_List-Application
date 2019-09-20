import 'package:flutter/material.dart';

import 'product_edit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';

class ProductListPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.products[index].title),
            background: Container(color: Colors.red),
            onDismissed: (DismissDirection direction) =>
                model.deleteProduct(index),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(model.products[index].image),
                  ),
                  title: Text(model.products[index].title),
                  subtitle: Text("\$${model.products[index].price.toString()}"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductEditPage.edit(
                                product: model.products[index], index: index),
                          ),
                        ),
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
