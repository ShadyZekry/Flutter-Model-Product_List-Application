import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  bool favouriteFilter = false;

  List<Product> get products => favouriteFilter
      ? _products.where((Product product) => product.isFavourite).toList()
      : List.from(_products);

  void addProduct(Product product) {
    http
        .post("https://flutter-test-36ced.firebaseio.com/products.json",
            body: json.encode(product.toMap()))
        .then((http.Response response) {
      product.id = json.decode(response.body)["name"];
          _products.add(product);

    });
    notifyListeners();
  }

  void deleteProduct(int index) {
    http.delete("https://flutter-test-36ced.firebaseio.com/products/${products[index].id}.json");
    _products.removeAt(index);
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    http.put(
        "https://flutter-test-36ced.firebaseio.com/products/${product.id}.json",
        body: json.encode(product.toMap()));
    notifyListeners();
    _products[index] = product;
  }

  void togleFavouriteStatus(int index) {
    products[index].isFavourite = !products[index].isFavourite;
    notifyListeners();
  }

  void toggleFavouriteFilter() {
    favouriteFilter = !favouriteFilter;
    notifyListeners();
  }

  Future fetchProducts() async {
    await http
        .get("https://flutter-test-36ced.firebaseio.com/products.json")
        .then((http.Response responce) {
      final List<Product> fetchedProducts = [];
      final Map<String, dynamic> productList = json.decode(responce.body);
      productList.forEach((String id, dynamic map) {
        _addMapToList(id, map, fetchedProducts);
      });
      _products = fetchedProducts;
      notifyListeners();
    });
  }

  void _addMapToList(String id, Map map, List<Product> fetchedProducts) {
    Product product = Product(
        title: null,
        details: null,
        price: null,
        id: null,
        userEmail: null,
        userId: null);

    product.title = map["title"];
    product.details = map["details"];
    product.image = map["image"];
    product.price = map["price"];
    product.address = map["address"];
    product.id = id;
    product.userEmail = map["userEmail"];
    product.userId = map["userId"];

    fetchedProducts.add(product);
  }
}
