import 'package:Faster/Screens/NoConnection.dart';
import 'package:Faster/Screens/StoresScreen.dart';
import 'package:Faster/classes/product.dart';
import 'package:Faster/config/getUserLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Faster/Screens/configuration.dart';
import 'package:Faster/Screens/ProductDetails.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:device_apps/device_apps.dart';
//import '../Animations/FadeAnimation.dart';
import 'CarteScreen.dart';
import '../classes/mSystem.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  final _scrollController = ScrollController();

  bool isDrawerOpen = false;
  bool isEmptyCart = true;
  bool _isOffsetInTop = true;
  bool _isLoading = true;
  bool isLikedProductsListEmpty = false;
  List<Color> Background = [
    Color(0xFFA8C0D6),
    Color(0xFFBF3D69),
    Color(0xFFB9D5BC),
    Color(0xFFA8C0D6),
    Color(0xFF4D97C4),
    Color(0xFFD9C6A8)
  ];

  @override
  void initState() {
    _returnedData().then((value) => this._changeLoadingPage());
    super.initState();

    //bool IsRegistred =  mSystemLocator().getUserInfo();
  }

  Future _returnedData() async {
    GetUserLocation mLoc = GetUserLocation();
    await mLoc.grantPermission();
    bool setUserPosition = await mSystemLocator().setUserPosition(
        mSystemLocator.userLocation.latitude,
        mSystemLocator.userLocation.longitude);
    bool likedProducts = await mSystemLocator().getLikedProducts();
    /* print(likedProducts);
    if (!likedProducts) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoConnection()));
      return;
    } */
    bool productsBasedPosition =
        await mSystemLocator().getProductsBasedUserPosition();
    /* if (!productsBasedPosition) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoConnection()));
      return;
    } */
    //print(productsBasedPosition);
    bool productsCollection = await mSystemLocator().getProductsCollection();
    /* if (!productsCollection) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoConnection()));
      return;
    } */
  }

  void _changeLoadingPage() {
    setState(() {
      if (mSystemLocator.likedProducts.length == 0)
        isLikedProductsListEmpty = true;
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0)
        ..rotateZ(isDrawerOpen ? 0 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: (notification) {
              if (_scrollController.offset > 600)
                setState(() {
                  _isOffsetInTop = false;
                });
              else
                setState(() {
                  _isOffsetInTop = true;
                });
            },
            child: RefreshIndicator(
              onRefresh: () => _refreshScreen(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Color(0xFF61A4F1),
                    elevation: 2.0,
                    leading: isDrawerOpen
                        ? Transform.translate(
                            offset: const Offset(10.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Color(0xFF60A4F1),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                },
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                    expandedHeight: 200.0,
                    pinned: true,
                    actions: <Widget>[
                      isEmptyCart
                          ? IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartePage()));
                              })
                          : IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.red[400],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartePage()));
                              })
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        // height: 50.0,
                        child: Text(
                          'FASTER',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat-bold',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      background: Image.network(
                        'http://ec2-3-137-146-7.us-east-2.compute.amazonaws.com/upload/images/shopping.jpg',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : SpinKitDualRing(
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 25.0, top: 25.0, bottom: 15.0, right: 15.0),
                          decoration: BoxDecoration(color: Color(0xFF090B10)),
                          margin: EdgeInsets.only(top: 15.0),
                          height: 230.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Become',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontFamily: 'Montserrat-bold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'the FASTER',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontFamily: 'Montserrat-bold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Vendez vos prdouits \navec nous',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () async {
                                      bool isInstalled =
                                          await DeviceApps.isAppInstalled(
                                              'com.example.FasterBusiness');
                                      if (isInstalled)
                                        DeviceApps.openApp(
                                            'com.example.FasterBusiness');
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      'VOIR PLUS',
                                      style: TextStyle(
                                        color: Color(0xFF090B10),
                                        letterSpacing: 1.5,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat-bold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/fastdelivery.png'),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          )
                          /* ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => _categoryItem(index),
                    ), */
                          )),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 5.0,
                      width: double.infinity,
                      color: Colors.grey[400],
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 7.0),
                        width: 260.0,
                        decoration: BoxDecoration(
                            color: Color(0xFFD95380),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            top: 14.0,
                            bottom: 14.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Produits vous suivre',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontFamily: 'Montserrat-bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !_isLoading
                          ? Container(
                              margin: EdgeInsets.only(top: 4.0),
                              height: 190.0,
                              child: isLikedProductsListEmpty
                                  ? _likedListEmpty()
                                  : _likedProductsSlider(),
                            )
                          : _likedPorductsLoadiong(),
                    ],
                  )),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      height: 10.0,
                      width: double.infinity,
                      color: Colors.grey[400],
                    ),
                  ),
                  SliverAppBar(
                    elevation: 2.0,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        'http://ec2-3-137-146-7.us-east-2.compute.amazonaws.com/upload/images/allshopping.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),

                    leading: Icon(
                      Icons.stars,
                      color: Colors.white,
                    ),
                    //centerTitle: true,
                    title: Transform.translate(
                      offset: const Offset(-100, 0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFF60A4F1),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 20.0, top: 12.0, bottom: 12.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.stars,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Tout les produits',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Montserrat-bold',
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pinned: true,

                    backgroundColor: Color(0xFF8DBDF4),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return _productCardType2(mSystemLocator.allProducts[index]);
                  }, childCount: mSystemLocator.allProducts.length))
                ],
              ),
            ),
          ),
          _isOffsetInTop
              ? Container()
              : Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 20.0, bottom: 20.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _scrollController.animateTo(0.0,
                          duration: Duration(milliseconds: 3200),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(
                      Icons.arrow_upward,
                    ),
                    backgroundColor: Color(0xC261A4F1),
                  ),
                )
        ],
      ),
    );
  }

  Widget _likedProductsSlider() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mSystemLocator.likedProducts.length,
        itemBuilder: (context, index) =>
            _likedProductCard(mSystemLocator.likedProducts[index], index));
  }

  Widget _makeProductCard(int PrdId, String PrdName, double PrdPrice,
      String PrdImgUrl, String SellerUrl, String StoreName) {
    return GestureDetector(
      onTap: () {
        /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                    heroTag: PrdImgUrl,
                    foodName: PrdName,
                    foodPrice: PrdPrice.toString() + ' DZ'))); */
      },
      child: Container(
        height: 240,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              PrdImgUrl ?? '192.168.1.13:3000/upload/images'),
                          fit: BoxFit.cover),

                      //color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: shadowList,
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                    child: Text(PrdName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(PrdPrice.toString() + ' DZ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Montserrat-bold',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400])),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                  image: AssetImage(SellerUrl),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 5.5,
                        ),
                        Text(StoreName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey))
                      ],
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.only(top: 25.0),
              margin: EdgeInsets.only(top: 65, bottom: 20),
              decoration: BoxDecoration(
                  //border: Border.all(width: 1.5, color: Colors.grey[300]),
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            )),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(int index) {
    return Column(
      children: <Widget>[
        Container(
          child: Container(
            height: 60.0,
            width: 60.0,
            margin: EdgeInsets.only(left: 10.0, right: 5.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: Background[index],
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(26.0)),
            child: Container(
              height: 30.0,
              width: 30.0,
              //margin: EdgeInsets.only(left: 20, bottom: 10.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(categories[index]['iconPath']),
                  ),
                  //  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(35.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            categories[index]['name'],
            style: TextStyle(
                fontSize: 11.5,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey[600]),
          ),
        )
      ],
    );
  }

  Widget _likedProductCard(Product prod, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      prodId: prod.id,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        alignment: Alignment.bottomLeft,
        height: 150.0,
        width: 120.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.translate(
              offset: const Offset(0, 10),
              child: Container(
                margin: EdgeInsets.only(left: 7.0),
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0xFFD95380)),
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                        image: NetworkImage(prod.storeImg ??
                            'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8.0, bottom: 5.0),
              padding:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, right: 5, left: 5),
              decoration: BoxDecoration(
                  color: Color(0xA80000000),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Text(
                prod.price.toString(),
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat-bold'),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[400],
            border: Border.all(width: 1, color: Colors.grey[500]),
            image: DecorationImage(
                image: NetworkImage(prod.image ??
                    'http://192.168.1.13:3000/upload/images/product.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(18.0)),
      ),
    );
  }

  Widget _likedListEmpty() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.grey[500],
            child: Icon(
              Icons.grid_off,
              size: 70.0,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Vous n\'avez suivre aucun boutique\n    Abonnez les FASTER boutiques ',
            style: TextStyle(
              fontFamily: 'Montserrat-bold',
              fontSize: 14.0,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 17.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => StoresPage()));
            },
            elevation: 0.0,
            padding: EdgeInsets.only(
                top: 14.0, bottom: 14.0, right: 50.0, left: 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.0),
            ),
            color: Color(0xFF1C1527),
            child: Container(
              width: 130.0,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Boutiques",
                    style: TextStyle(
                      color: Colors.grey[200],
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _productCardType2(Product prod) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      prodId: prod.id,
                    )));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0, bottom: 5.0),
        decoration: BoxDecoration(
            boxShadow: shadowList,
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFFEF8F3)),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0),
              height: 150.0,
              width: 180.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  //border: Border.all(width: 3, color: Color(0xFFFF9800)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  image: DecorationImage(
                      image: NetworkImage(prod.image), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(prod.name,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontFamily: 'Montserrat-bold')),
                SizedBox(
                  height: 5.0,
                ),
                Text(prod.price.toString() + ' DZD',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        fontFamily: 'Montserrat-bold')),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 1.0,
                  width: 75.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(prod.seller,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat')),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0, right: 5.0),
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(18.0),
                          image: DecorationImage(
                              image: NetworkImage(prod.storeImg ??
                                  'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                              fit: BoxFit.cover)),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFBC00),
                      size: 20.0,
                    ),
                    Text(prod.rating.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat-bold',
                            fontSize: 13.0,
                            color: Color(0xFFFFBC00))),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _likedPorductsLoadiong() {
    return Column(
      children: <Widget>[
        Container(
          height: 180.0,
          width: double.infinity,
          child: SpinKitRing(
            color: Colors.blue,
            size: 80.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text('Chargement...',
            style: TextStyle(
                fontFamily: 'Montserrat-bold',
                fontSize: 15.0,
                color: Colors.grey[500])),
      ],
    );
  }

  Future<bool> _refreshScreen() async {
    try {
      setState(() {
        _isLoading = true;
        isLikedProductsListEmpty = false;
      });
      await _returnedData().then((value) => this._changeLoadingPage());
      return true;
    } catch (e) {}
  }
}
