import 'package:Faster/classes/product.dart';

class CartItem {
  Product prod;
  int quantity;

  CartItem(Product prod, int quantity) {
    this.prod = prod;
    this.quantity = quantity;
  }
}
