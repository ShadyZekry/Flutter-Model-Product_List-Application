import 'package:scoped_model/scoped_model.dart';

import './product_model.dart';
import './user_model.dart';

class MainModel extends Model with ProductModel, UserModel {}