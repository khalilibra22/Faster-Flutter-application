//import 'dart:ffi';

import 'package:Faster/classes/cartItem.dart';
import 'package:Faster/classes/product.dart';
import 'package:Faster/classes/storeCartPart.dart';
import 'package:Faster/config/CustomToast.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'CammandConfirmation.dart';
import '../classes/mSystem.dart';

class CartePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CartePage> {
  bool _isEmptyList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('FASTER',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('Panier',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 180.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: !mSystemLocator.storeCart.isEmpty
                            ? ListView.builder(
                                itemCount: mSystemLocator.storeCart.length,
                                itemBuilder: (context, index) =>
                                    _makeStoreCartItem(
                                        mSystemLocator.storeCart[index], index))
                            : _emptyCart())),
                SizedBox(height: 10.0),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text('${_getCartTotal()} DZD',
                            style: TextStyle(
                                fontFamily: 'Montserrat-bold',
                                color: Color(0xFF22BFBD),
                                fontSize: 18.0)),
                      ),
                      InkWell(
                        onTap: () {
                          if (mSystemLocator.storeCart.isEmpty) {
                            mToast().infoMessage('Le panier est vide');
                            return;
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CammandPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Color(0xFF22BFBD)),
                          height: 63.0,
                          width: 190.0,

                          //color: Color(0xFF21BFBD),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.payment,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Text('Commander',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat-bold',
                                      color: Colors.white,
                                      fontSize: 18.0)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Hero(
                  tag: index,
                  child: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                            image: NetworkImage(item.prod.image),
                            fit: BoxFit.cover)),
                  )),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.prod.name,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                Text(item.prod.price.toString() + ' DZD',
                    style: TextStyle(
                        fontFamily: 'Montserrat-bold',
                        fontSize: 14.0,
                        color: Colors.green[300])),
                Text('Qnt: ' + item.quantity.toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat-bold',
                        fontSize: 13.0,
                        color: Colors.black))
              ])
            ])),
            Row(
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.red[400],
                  highlightColor: Colors.red[200],
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.red[400],
                    size: 30.0,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.red[400],
                  highlightColor: Colors.red[200],
                  child: Text('Supprimer',
                      style: TextStyle(
                          fontFamily: 'Montserrat-bold',
                          fontSize: 13.0,
                          color: Colors.red[400])),
                ),
              ],
            )
          ],
        ));
  }

  Widget _makeStoreCartItem(StoreCart item, int index) {
    return InkWell(
      onTap: () {
        _bottomPopupSheet(context, index);
      },
      child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Row(children: [
                Hero(
                    tag: index,
                    child: Image(
                        image: NetworkImage(item.storeImgUrl ??
                            'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0)),
                SizedBox(width: 10.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.storeName,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  Text('Total:',
                      style: TextStyle(
                          fontFamily: 'Montserrat-bold',
                          fontSize: 13.0,
                          color: Colors.black)),
                  Text(item.getTotal().toString() + ' DZD',
                      style: TextStyle(
                          fontFamily: 'Montserrat-bold',
                          fontSize: 14.0,
                          color: Colors.green[300])),
                ])
              ])),
              Icon(
                Icons.more_vert,
                size: 30.0,
                color: Colors.green,
              )
            ],
          )),
    );
  }

  void _bottomPopupSheet(context, int position) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 2.0,
                    backgroundColor: Colors.white,
                    leading: Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                    ),
                    //centerTitle: true,
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            color: Color(0xFF21BFBD),
                            size: 22.0,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            mSystemLocator.storeCart[position].storeName ??
                                'Boutique',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Montserrat-bold',
                                color: Color(0xFF21BFBD)),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        if (mSystemLocator
                                .storeCart[position].products.length ==
                            1) Navigator.pop(context);

                        mSystemLocator.storeCart[position].products
                            .removeAt(index);
                        _checkList(position);
                      },
                      key: Key(mSystemLocator
                          .storeCart[position].products[index].prod.id
                          .toString()),
                      child: _buildCartItem(
                          mSystemLocator.storeCart[position].products[index],
                          index),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        color: Colors.red[400],
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_shopping_cart,
                              color: Colors.white,
                              size: 27.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Supprimer',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Montserrat-bold',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );

                    /* return _makeProductCard(1, 'hjghj jkh', 222.32,
                      'assets/window.jpeg', 'assets/hugh.jpg', 'klfdsjf'); */
                  },
                          childCount: mSystemLocator
                              .storeCart[position].products.length))
                ],
              ),
            ),
          );
        });
  }

  void _checkList(int index) async {
    if (mSystemLocator.storeCart[index].products.isEmpty) {
      setState(() {
        mSystemLocator.storeCart.removeAt(index);
      });
    }
  }

  dynamic _getCartTotal() {
    var sum = 0;
    for (int i = 0; i < mSystemLocator.storeCart.length; i++) {
      sum += mSystemLocator.storeCart[i].getTotal();
    }

    return sum;
  }

  Widget _emptyCart() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Shimmer.fromColors(
              child: Icon(
                Icons.remove_shopping_cart,
                size: 80.0,
              ),
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[500]),
          SizedBox(
            height: 15.0,
          ),
          Shimmer.fromColors(
              child: Text(
                'Panier vide',
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Montserrat-bold',
                    color: Colors.white),
              ),
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[500]),
        ],
      ),
    );
  }
}
/*ListView.builder(
                        itemCount:
                            mSystemLocator.storeCart[position].products.length,
                        itemBuilder: (context, index) => _buildCartItem(
                            mSystemLocator.storeCart[position].products[index],
                            index)),
                  )*/
