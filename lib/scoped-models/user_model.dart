import '../models/user.dart';
import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User _authinticationUser;

  void login(String email, String passWord) {
    _authinticationUser = User(email: email, passWord: passWord, id: "id1");
  }

  void loginAsGuest() {
    _authinticationUser = User(email: "Guest@guest.com", passWord: "123123", id: "id2");
  }

  void assignUserToProduct(Product product) {
    product.userEmail = _authinticationUser.email;
    product.userId = _authinticationUser.id;
  }
}
