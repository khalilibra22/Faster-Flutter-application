import 'package:Faster/classes/cartItem.dart';

class StoreCart {
  var sellerId;
  var userId;
  String storeName;
  String storeImgUrl;
  String recipientName;
  String recipientPhone;
  String address;
  var lat;
  var long;
  var creationTime;
  String notificationToken;
  List<CartItem> products = List<CartItem>();

  StoreCart(
      this.sellerId,
      this.userId,
      this.storeName,
      this.storeImgUrl,
      this.recipientName,
      this.recipientPhone,
      this.address,
      this.creationTime,
      this.lat,
      this.long);

  void addItmeToList(CartItem newItem) {
    for (int i = 0; i < products.length; i++) {
      if (newItem.prod.id == products[i].prod.id) {
        products[i].quantity += newItem.quantity;
        return;
      }
    }
    products.add(newItem);
  }

  dynamic getTotal() {
    var total = products[0].prod.price * products[0].quantity;

    for (int i = 1; i < products.length; i++) {
      total += products[i].prod.price * products[i].quantity;
    }
    return total;
  }
}
