import 'package:Faster/classes/product.dart';

class Order {
  String id;
  Product prod;
  int quantity;
  var total;
  DateTime orderDeliveryTime;
  bool isCompleted;
  String profileImgUrl;

  Order(String id, Product prod, int quantity, bool isCompleted,
      DateTime orderDeliveryTime, String profileImgUrl) {
    this.id = id;
    this.prod = prod;
    this.quantity = quantity;
    this.total = this.prod.price * this.quantity;
    this.isCompleted = isCompleted;
    this.orderDeliveryTime = orderDeliveryTime;
    this.profileImgUrl = profileImgUrl;
  }
}
