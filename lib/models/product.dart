import 'package:flutter/material.dart';

class Product {
  String title;
  String details;
  String image;
  double price;
  String address;
  String id;
  bool isFavourite = false;

  String userEmail;
  String userId;

  Product({
    @required this.title,
    @required this.details,
    this.image =
        "https://cdn-prod.medicalnewstoday.com/content/images/articles/321/321618/dark-chocolate-and-cocoa-beans-on-a-table.jpg",
    @required this.price,
    this.address = "Alf Maskan, Cairo, Egypt",
    @required this.id,
    @required this.userEmail,
    @required this.userId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "details": details,
      "image": image,
      "price": price,
      "address": address,
      "userEmail": userEmail,
      "UserId": userId,
      "id": id,
    };
    return map;
  }
}
