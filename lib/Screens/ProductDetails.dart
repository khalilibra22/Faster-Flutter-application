import 'package:Faster/Screens/CarteScreen.dart';
import 'package:Faster/Screens/NoConnection.dart';
import 'package:Faster/classes/cartItem.dart';
import 'package:Faster/classes/product.dart';
import 'package:Faster/classes/storeCartPart.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../classes/mSystem.dart';
//import 'package:Faster/Screens/configuration.dart';

class DetailsPage extends StatefulWidget {
  final prodId;

  DetailsPage({
    this.prodId,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';

  bool _isloading = true;
  bool _isImageUp = false;
  int _productQuantity = 1;

  Product _prod =
      Product(-1, '', -1.0, 'assets/hugh.jpg', '', 'assets/hugh.jpg');

  @override
  void initState() {
    //TODO: implement product info to _product
    _returnedData().then((value) => this._changeloadingScreen());

    super.initState();
  }

  Future _returnedData() async {
    Product mProduct = await mSystemLocator().getProductsById(widget.prodId);
    if (mProduct == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoConnection()));
      return;
    }
    _prod = mProduct;
  }

  void _changeloadingScreen() {
    setState(() {
      _isloading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Détaille',
              style: TextStyle(
                  fontFamily: 'Montserrat-bold',
                  fontSize: 20.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            ListView(children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 82.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 75.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              topRight: Radius.circular(45.0),
                            ),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height - 100.0,
                        width: MediaQuery.of(context).size.width)),
                Positioned(
                    top: 30.0,
                    left: (MediaQuery.of(context).size.width / 2) - 135.0,
                    child: Hero(
                        tag: widget.prodId,
                        child: _isloading
                            ? _productImageloadingAnimation()
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isImageUp = true;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                        image: DecorationImage(
                                            image: NetworkImage(_prod.image ??
                                                'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                                            fit: BoxFit.cover)),
                                    height: 205.0,
                                    width: 270.0),
                              ))),
                _isloading ? _loadingAnimation() : _productInfo()
              ])
            ]),
            _isImageUp
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isImageUp = false;
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Color(0xDD000000),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 50.0),
                            /* Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isImageUp = false;
                                    });
                                  },
                                )
                              ],
                            ), */
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  image: DecorationImage(
                                      image: NetworkImage(_prod.image ??
                                          'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                                      fit: BoxFit.contain)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }

  Widget _productInfo() {
    return Positioned(
        top: 250.0,
        left: 25.0,
        right: 25.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_prod.name,
                style: TextStyle(
                    fontFamily: 'Montserrat-bold',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_prod.price.toString() + ' DZD',
                    style: TextStyle(
                        fontFamily: 'Montserrat-bold',
                        fontSize: 23.0,
                        color: Colors.green[400])),
                Container(height: 25.0, color: Colors.grey, width: 1.0),
                Container(
                  width: 125.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Color(0xFF7A9BEE)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_productQuantity > 1) _productQuantity--;
                          });
                        },
                        child: Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Color(0xFF7A9BEE)),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Text(_productQuantity.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 15.0)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _productQuantity++;
                          });
                        },
                        child: Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF7A9BEE),
                              size: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 35.0),
            Container(
              height: 50.0,
              child: ListView(
                children: <Widget>[
                  _buildInfoCard(),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 30.0,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                    'ghjg hjghj kghjg hjghj hhgjh fhg yyyyy fghfhgf'
                            .substring(0, 35) +
                        ' ...',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: NetworkImage(_prod.storeImg ??
                              'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 5.5,
                ),
                Text(_prod.seller,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey))
              ],
            ),
            SizedBox(height: 20.0),
            _add2CartBtn()
          ],
        ));
  }

  Widget _buildInfoCard() {
    return Text(
      _prod.desc ?? 'Vide',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15.0,
      ),
    );
  }

  showSnackBar(
    context,
  ) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text('Votre produit est ajouté au panier',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Montserrat',
              )),
          action: SnackBarAction(
            label: 'Voir le panier',
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartePage()));
            },
          ),
          duration: Duration(seconds: 3)),
    );
  }

  void _isAddedToCart() async {
    bool isAdded = await mSystemLocator().addToCart(_prod, _productQuantity);
  }

  Widget _add2CartBtn() {
    return Builder(
        builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: GestureDetector(
                onTap: () {
                  _isAddedToCart();
                  showSnackBar(context);

                  /* for (int i = 0; i < mSystemLocator.storeCart.length; i++) {
                    if (mSystemLocator.storeCart[i].sellerId == _prod.sellerId)
                      mSystemLocator.storeCart[i]
                          .addItmeToList(CartItem(_prod, _productQuantity));
                    
                    return;
                  }
 
                  StoreCart newStoreCart = StoreCart(
                      _prod.sellerId, 10, '', '', '', DateTime.now(), 0, 0);
                  newStoreCart.addItmeToList(CartItem(_prod, _productQuantity)); */

                  /* for (int i = 0; i < mSystemLocator.cart.length; i++) {
                    if (mSystemLocator.cart[i].prod.id == _prod.id) {
                      mSystemLocator.cart[i].quantity += _productQuantity;
                      showSnackBar(context);
                      return;
                    }
                  }
                  mSystemLocator.cart.add(CartItem(_prod, _productQuantity));
                  showSnackBar(context); */
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),
                      color: Colors.black),
                  height: 80.0,
                  child: Center(
                    child: Text('Ajouter au panier',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ),
                ),
              ),
            ));
  }

  Widget _loadingAnimation() {
    return Positioned(
        top: 250.0,
        left: 25.0,
        right: 25.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                height: 20.0,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 20.0,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  Container(height: 25.0, color: Colors.grey, width: 1.0),
                  Container(
                    width: 125.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: Color(0xFF7A9BEE)),
                  )
                ],
              ),
              SizedBox(height: 35.0),
              Container(
                height: 90.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 280,
                      height: 12.0,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 300,
                      height: 12.0,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 250,
                      height: 12.0,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 270,
                      height: 12.0,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage('assets/hugh.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 5.5,
                    ),
                    Container(
                      width: 180,
                      height: 15.0,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(6.0)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              _add2CartBtn()
            ],
          ),
        ));
  }

  Widget _productImageloadingAnimation() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.grey[300],
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              image: DecorationImage(
                  image: AssetImage('assets/hugh.jpg'), fit: BoxFit.cover)),
          height: 205.0,
          width: 270.0),
    );
  }
}

/* Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          mSystemLocator.cart
                              .add(CartItem(_product, _productQuantity));
                          showSnackBar(_myContext);

                          /* showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Ajouté au panier',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Montserrat-bold'),
                                  ),
                                ],
                              ),
                              elevation: 10.0,
                              content:
                                  Text('Votre produit est ajouté au panier',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      )),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartePage()));
                                    },
                                    child: Text('Voir le panier',
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue))),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Continue',
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)))
                              ],
                              //shape: CircleBorder(),
                            ),
                          ); */
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0)),
                              color: Colors.black),
                          height: 80.0,
                          child: Center(
                            child: Text('Ajouter au panier',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ) */
