class Store {
  int id;
  String storeName;
  String address;
  var deliveryTime;
  var rating;
  String imgUrl;
  bool isLiked;

  Store(int id, String storeName, String address, var deliveryTime, var rating,
      String imgUrl, bool isLiked) {
    this.id = id;
    this.storeName = storeName;
    this.address = address;
    this.deliveryTime = deliveryTime;
    this.rating = rating;
    this.imgUrl = imgUrl;
    this.isLiked = isLiked;
  }
}
