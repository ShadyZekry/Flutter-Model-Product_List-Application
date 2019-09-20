import 'package:flutter/material.dart';

import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';

class ProductEditPage extends StatefulWidget {
  Product product = Product(title: "null", details: null, price: null);
  int index;

  ProductEditPage();
  ProductEditPage.edit({this.index, this.product});

  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      initialValue: widget.index == null ? "" : widget.product.title,
      decoration: InputDecoration(labelText: "Title"),
      validator: (String value) {
        if (value.length < 4 || value.isEmpty) return "This is a small title";
      },
      onSaved: (String value) => widget.product.title = value,
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      initialValue: widget.index == null ? "" : widget.product.details,
      decoration: InputDecoration(labelText: "Description"),
      maxLines: 2,
      validator: (String value) {
        if (value.length < 5 || value.isEmpty)
          return "Description must be 5+ chars";
      },
      onSaved: (String value) => widget.product.details = value,
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue: widget.index == null ? "" : widget.product.price.toString(),
      decoration: InputDecoration(labelText: "Price"),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
          return "This is not a valid price";
      },
      onSaved: (String value) => widget.product.price = double.parse(value),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSaveButton(Function addProduct, Function updateProduct,
      Function assignUserToProduct) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      child: Text("Save"),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        if (widget.index != null) {
          updateProduct(widget.index, widget.product);
          assignUserToProduct(widget.product);
          Navigator.pop(context);
          return;
        }
        assignUserToProduct(widget.product);
        addProduct(widget.product);
        Navigator.pushReplacementNamed(context, "/home");
      },
    );
  }

  Widget build(BuildContext context) {
    final Widget _buildEditPage = Container(
      margin: EdgeInsets.all(5.0),
      child: Form(
        key: _formKey,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.025),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              _buildSaveButton(model.addProduct, model.updateProduct,
                  model.assignUserToProduct),
            ],
          );
        }),
      ),
    );
    return widget.index == null
        ? _buildEditPage
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit product"),
            ),
            body: _buildEditPage,
          );
  }
}
