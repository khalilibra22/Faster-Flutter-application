import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'product.dart';
import 'User.dart';
import 'store.dart';
import 'order.dart';
import 'cartItem.dart';
import 'storeCartPart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mSystemLocator {
  static List<Product> allProducts = List<Product>();
  static List<Product> likedProducts = List<Product>();
  static List<Store> stores = List<Store>();
  static List<Order> orders = List<Order>();
  static List<CartItem> cart = List<CartItem>();
  static List<StoreCart> storeCart = List<StoreCart>();

  String _apiUrl = 'http://ec2-3-137-146-7.us-east-2.compute.amazonaws.com/api';
  SharedPreferences _prefs;
  static LocationData userLocation;
  mSystemLocator();

  Future<bool> CreateNewUser(
      String FullName, String Phone, String Email, String Password) async {
    String CreateUserApi = _apiUrl + '/users';
    try {
      var response = await http.post(CreateUserApi,
          body: json.encode({
            'Email': Email,
            'Phone': Phone,
            'Pass': Password,
          }),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });
      Map<String, dynamic> SignupValidation = jsonDecode(response.body);
      int ReturnedCode = SignupValidation['code'];
      if (ReturnedCode == 0) return false;
      return true;
    } catch (e) {
      return false;
    }

//print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
  }

  Future<int> UserLogin(String Email, String Password) async {
    String CreateUserApi = _apiUrl + '/users/login';
    try {
      var response = await http.post(CreateUserApi,
          body: json.encode({'email': Email, 'UserPassword': Password}),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          });

      Map<String, dynamic> checkToken = jsonDecode(response.body);
      //int ReturnedCode = CheckToken['code'];
      print(response.statusCode);
      if (response.statusCode == 200) {
        _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', checkToken['UserToken']);
        _prefs.setInt('UserId', checkToken['UserId']);
        print(User().getUser());
      }

      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<bool> getUserInfo() async {
    try {
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/users/' + userId.toString();
      String authToken = await getToken();
      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });

      Map<String, dynamic> UserInfo = jsonDecode(response.body);
      if (UserInfo['code'] == 0) return false;
      User.id = UserInfo['result']['UserID'];
      User.fullName = UserInfo['result']['FullName'];
      User.email = UserInfo['result']['Email'];
      User.phone = UserInfo['result']['PhoneNumber'];
      User.adress = UserInfo['result']['UserAddress'];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setUserInfo(
      String fullName, String email, String phone, String address) async {
    try {
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/users';
      String authToken = await getToken();
      var response = await http.put(CreateUserApi,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            HttpHeaders.authorizationHeader: authToken,
          },
          body: jsonEncode({
            'UserID': userId,
            'FullName': fullName,
            'Email': email,
            'Phone': phone,
            'Address': address
          }));

      Map<String, dynamic> UserInfo = jsonDecode(response.body);
      print((response.body));
      if (UserInfo['code'] == 0) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getLikedStores() async {
    try {
      stores.clear();
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/likedstores/id/${userId.toString()}';
      String authToken = await getToken();
      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> storesData = jsonDecode(response.body);
      int returnedCode = storesData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> likedStoresList = storesData['result'];

      for (int i = 0; i < likedStoresList.length; i++) {
        var nwItem = Store(
            likedStoresList[i]['SellerID'],
            likedStoresList[i]['SellerStoreName'],
            likedStoresList[i]['SellerAddress'],
            likedStoresList[i]['SellerDeliveryTime'],
            likedStoresList[i]['SellerRating'],
            likedStoresList[i]['SellerProfilImgURL'],
            true);
        stores.add(nwItem);
      }
      print(response.body);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getStoresUsingGps() async {
    try {
      int userId = await getUserId();
      String CreateUserApi =
          _apiUrl + '/likedstores/basedPosition/${userId.toString()}';
      String authToken = await getToken();
      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> storesData = jsonDecode(response.body);
      int returnedCode = storesData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> gpsStoresList = storesData['result'];
      //stores.clear();
      for (int i = 0; i < gpsStoresList.length; i++) {
        var nwItem = Store(
            gpsStoresList[i]['SellerID'],
            gpsStoresList[i]['SellerStoreName'],
            gpsStoresList[i]['SellerAddress'],
            gpsStoresList[i]['SellerDeliveryTime'],
            gpsStoresList[i]['SellerRating'],
            gpsStoresList[i]['SellerProfilImgURL'],
            false);
        stores.add(nwItem);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getStoresCollection() async {
    try {
      int userId = await getUserId();
      String CreateUserApi =
          _apiUrl + '/likedstores/collection/${userId.toString()}';
      String authToken = await getToken();
      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> storesData = jsonDecode(response.body);
      int returnedCode = storesData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> storesCollectionList = storesData['result'];
      //stores.clear();
      print(response.body);
      for (int i = 0; i < storesCollectionList.length; i++) {
        var nwItem = Store(
            storesCollectionList[i]['SellerID'],
            storesCollectionList[i]['SellerStoreName'],
            storesCollectionList[i]['SellerAddress'],
            storesCollectionList[i]['SellerDeliveryTime'],
            storesCollectionList[i]['SellerRating'],
            storesCollectionList[i]['SellerProfilImgURL'],
            false);
        stores.add(nwItem);
      }
      print(response.body);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> disLikeStore(int sellerId) async {
    try {
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/likedstores';
      String authToken = await getToken();

      var response = await http.put(CreateUserApi,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            HttpHeaders.authorizationHeader: authToken,
          },
          body: json.encode({'UserID': userId, 'SellerID': sellerId}));

      print('result is : ${response.body}');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> likeStore(int sellerId) async {
    try {
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/likedstores';
      String authToken = await getToken();

      var response = await http.post(CreateUserApi,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            HttpHeaders.authorizationHeader: authToken,
          },
          body: json.encode({'UserID': userId, 'SellerID': sellerId}));

      print('result is : ${response.body}');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getUserOrders() async {
    try {
      int userId = await getUserId();
      String CreateUserApi = _apiUrl + '/orders/users/${userId}';
      String authToken = await getToken();
      orders.clear();
      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      print(response.body);
      Map<String, dynamic> ordersData = jsonDecode(response.body);
      int returnedCode = ordersData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> ordersList = ordersData['result'];

      for (int i = 0; i < ordersList.length; i++) {
        var nwProd = Product(
            ordersList[i]['ProductID'],
            ordersList[i]['ProductName'],
            ordersList[i]['SellPrice'],
            null,
            null,
            null);
        bool isCompleted = false;
        if (ordersList[i]['IsCompleted'] == 1) isCompleted = true;
        DateTime date;
        try {
          date = DateTime.parse(ordersList[i]['OrderDeliveryTime']);
        } catch (e) {
          date = DateTime.now();
        }

        var nwOrder = Order(
            ordersList[i]['OrderID'],
            nwProd,
            ordersList[i]['Quantity'],
            isCompleted,
            date,
            ordersList[i]['SellerProfilImgURL']);
        orders.add(nwOrder);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createOrder(
      var sellerId,
      String recipientName,
      String recipientPhone,
      String address,
      var lat,
      var long,
      var creationTime,
      var products,
      String notifiyToken) async {
    int userId = await getUserId();
    String CreateUserApi = _apiUrl + '/orders';
    String authToken = await getToken();

    var response = await http.post(CreateUserApi,
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          HttpHeaders.authorizationHeader: authToken,
        },
        body: json.encode({
          'UserID': userId,
          'SellerID': sellerId,
          'RecipientName': recipientName,
          'RecipientPhone': recipientPhone,
          'RecipientAddress': address,
          'RecipientLocLat': lat,
          'RecipientLocLong': long,
          'OrderCreationTime': creationTime,
          'OrderDeliveryTime':
              DateTime.now().add(Duration(hours: 6)).toString(),
          'notificationToken': notifiyToken,
          'products': products
        }));
    Map<String, dynamic> orderStatue = jsonDecode(response.body);
    int returnedCode = orderStatue['code'];
    if (returnedCode != 1) return false;
    print('result is : ${response.body}');
    return true;
  }

  Future<bool> getLikedProducts() async {
    try {
      int userId = await getUserId();
      String CreateUserApi =
          _apiUrl + '/products/likedproducts/${userId.toString()}';
      String authToken = await getToken();
      likedProducts.clear();

      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });

      Map<String, dynamic> likedProductsData = jsonDecode(response.body);
      int returnedCode = likedProductsData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> likedProductsList = likedProductsData['result'];
      for (int i = 0; i < likedProductsList.length; i++) {
        Product nwProd = Product(
            likedProductsList[i]['ProductID'],
            likedProductsList[i]['ProductName'],
            likedProductsList[i]['SellPrice'],
            likedProductsList[i]['ProductImage'],
            likedProductsList[i]['SellerStoreName'],
            likedProductsList[i]['SellerProfilImgURL']);
        likedProducts.add(nwProd);
      }
      print('liked :::: >> ' + response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getProductsBasedUserPosition() async {
    try {
      int userId = await getUserId();
      String CreateUserApi =
          _apiUrl + '/products/baseduserlocation/' + userId.toString();
      String authToken = await getToken();
      allProducts.clear();

      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> gpsProductsData = jsonDecode(response.body);
      int returnedCode = gpsProductsData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> gpsProductsList = gpsProductsData['result'];
      for (int i = 0; i < gpsProductsList.length; i++) {
        Product nwProd = Product(
            gpsProductsList[i]['ProductID'],
            gpsProductsList[i]['ProductName'],
            gpsProductsList[i]['SellPrice'],
            gpsProductsList[i]['ProductImage'],
            gpsProductsList[i]['SellerStoreName'],
            gpsProductsList[i]['SellerProfilImgURL']);
        nwProd.rating = gpsProductsList[i]['SellerRating'];
        allProducts.add(nwProd);
      }
      print('gps :::: >> ' + response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getProductsCollection() async {
    try {
      String CreateUserApi = _apiUrl + '/products/collection';
      String authToken = await getToken();

      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> collectionOfProductsData = jsonDecode(response.body);
      int returnedCode = collectionOfProductsData['code'];
      if (returnedCode != 1) return false;
      List<dynamic> collectionOfProductsList =
          collectionOfProductsData['result'];
      for (int i = 0; i < collectionOfProductsList.length; i++) {
        Product nwProd = Product(
            collectionOfProductsList[i]['ProductID'],
            collectionOfProductsList[i]['ProductName'],
            collectionOfProductsList[i]['SellPrice'],
            collectionOfProductsList[i]['ProductImage'],
            collectionOfProductsList[i]['SellerStoreName'],
            collectionOfProductsList[i]['SellerProfilImgURL']);
        nwProd.rating = collectionOfProductsList[i]['SellerRating'];

        /*if (!allProducts.contains(nwProd))*/ allProducts.add(nwProd);
      }

      print('collection :::: >> ' + response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Product> getProductsById(int id) async {
    try {
      String CreateUserApi = _apiUrl + '/products/id/' + id.toString();
      String authToken = await getToken();

      var response = await http.get(CreateUserApi, headers: {
        "accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: authToken,
      });
      Map<String, dynamic> collectionOfProductsData = jsonDecode(response.body);
      int returnedCode = collectionOfProductsData['code'];
      if (returnedCode != 1) return null;
      final collectionOfProductsList = collectionOfProductsData['result'];

      Product returnedProduct = Product(
          collectionOfProductsList['ProductID'],
          collectionOfProductsList['ProductName'],
          collectionOfProductsList['SellPrice'],
          collectionOfProductsList['ProductImages'],
          collectionOfProductsList['SellerStoreName'],
          collectionOfProductsList['SellerProfilImgURL']);
      returnedProduct.sellerId = collectionOfProductsList['SellerID'];
      returnedProduct.desc = collectionOfProductsList['ProdDescription'];
      returnedProduct.notifiyToken =
          collectionOfProductsList['notificationToken'];

      print(response.body);
      return returnedProduct;
    } catch (e) {
      return null;
    }
  }

  Future<bool> setUserPosition(var lat, var long) async {
    try {
      int userId = await getUserId();
      String createUserApi = _apiUrl + '/users/position';
      String authToken = await getToken();

      var response = await http.put(createUserApi,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            HttpHeaders.authorizationHeader: authToken,
          },
          body: json
              .encode({'UserID': userId, 'UserLat': lat, 'Userlong': long}));

      print('result is : ${response.body}');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> checkEmail(String email) async {
    String createUserApi = _apiUrl + '/users/checkemail';

    var response = await http.post(createUserApi,
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        },
        body: json.encode({'email': email}));

    print('result is : ${response.body}');

    return response.statusCode;
  }

  Future<bool> addToCart(Product prod, int quantity) async {
    int userId = await getUserId();
    for (int i = 0; i < storeCart.length; i++) {
      if (storeCart[i].sellerId == prod.sellerId) {
        storeCart[i].addItmeToList(CartItem(prod, quantity));
        return true;
      }
    }

    StoreCart newStoreCart = StoreCart(prod.sellerId, userId, prod.seller,
        prod.storeImg, '', '', '', DateTime.now(), 0, 0);
    newStoreCart.notificationToken = prod.notifiyToken;
    newStoreCart.addItmeToList(CartItem(prod, quantity));
    storeCart.add(newStoreCart);
    return true;
  }

  Future<String> getToken() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString('token') ?? '';
      return token;
    } catch (e) {}
  }

  Future<int> getUserId() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      int token = _prefs.getInt('UserId') ?? '';
      return token;
    } catch (e) {}
  }

  Future<bool> checkConnection() async {
    try {
      var response = await http.get(_apiUrl);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
