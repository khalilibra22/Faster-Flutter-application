/* import 'package:Faster/classes/cartItem.dart';
import 'package:Faster/classes/storeCartPart.dart';
import 'package:flutter/material.dart';
import 'CammandConfirmation.dart';
import '../classes/mSystem.dart';

class CartePageBeta extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CartePageBeta> {
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
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              StoreCart item = StoreCart(1, 'Pizza', '');
                              item.addNewCartItem(mSystemLocator.cart[0]);
                              return _makeCartstoreItem(item, index);
                            }, childCount: mSystemLocator.cart.length))
                          ],
                        ))),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 65.0,
                      width: 65.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text('8',
                            style: TextStyle(
                                fontFamily: 'Montserrat-bold',
                                fontSize: 15.0,
                                color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 65.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text('2523.00 DZ',
                            style: TextStyle(
                                fontFamily: 'Montserrat-bold',
                                fontSize: 15.0,
                                color: Colors.green[300])),
                      )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CammandPage()));
                      },
                      child: Container(
                        height: 65.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF1C1428)),
                        child: Center(
                            child: Text('Cammander',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 15.0))),
                      ),
                    )
                  ],
                )
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
                  child: Image(
                      image: AssetImage('assets/hugh.jpg'),
                      fit: BoxFit.cover,
                      height: 75.0,
                      width: 75.0)),
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
            IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                color: Colors.red[200],
                onPressed: () {
                  if (mSystemLocator.cart.isEmpty) return;
                  setState(() {
                    mSystemLocator.cart.removeAt(index);
                  });
                })
          ],
        ));
  }

  Widget _makeCartstoreItem(StoreCart storeItem, int position) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/hugh.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text('Store Name')
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
              itemCount: storeItem.items.length,
              itemBuilder: (context, index) =>
                  _buildCartItem(storeItem.items[index], index))
        ],
      ),
    );
  }
}
 */
