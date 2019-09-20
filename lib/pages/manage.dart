import 'package:flutter/material.dart';

import 'product_edit.dart';
import 'product_list.dart';

class ManagePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Page"),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "Add", icon: Icon(Icons.add)),
            Tab(text: "List", icon: Icon(Icons.list))
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage(),
          ],
        ),
      ),
    );
  }
}
