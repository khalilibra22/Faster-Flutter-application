import 'package:Faster/Screens/NoConnection.dart';
import 'package:flutter/material.dart';
import '../classes/mSystem.dart';
import 'package:shimmer/shimmer.dart';
import 'EmptyScreen.dart';

class OrdersPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OrdersPage> {
  bool isLoading = true;
  bool _isOrderListEmpty = false;

  @override
  void initState() {
    _returnedData().then((value) => this._changeloadingScreen());
    super.initState();

    //bool IsRegistred =  mSystemLocator().getUserInfo();
  }

  Future _returnedData() async {
    bool result = await mSystemLocator().getUserOrders();
    if (!result)
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoConnection()));
    if (mSystemLocator.orders.isEmpty) _isOrderListEmpty = true;
  }

  void _changeloadingScreen() {
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDB7A67),
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
                Text('Orders',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
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
                        height: MediaQuery.of(context).size.height - 250.0,
                        child: isLoading
                            ? _loadingDataAnimation()
                            : (_isOrderListEmpty ? EmptyPage() : _dataList()))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _dataList() {
    return ListView.builder(
        itemCount: mSystemLocator.orders.length,
        itemBuilder: (context, index) => _buildFoodItem(
            mSystemLocator.orders[index].profileImgUrl,
            mSystemLocator.orders[index].prod.name,
            mSystemLocator.orders[index].quantity,
            mSystemLocator.orders[index].total,
            mSystemLocator.orders[index].orderDeliveryTime,
            mSystemLocator.orders[index].isCompleted,
            index));
  }

  Widget _buildFoodItem(String imgPath, String productName, int quantity,
      var total, DateTime deliveryTime, bool isCompleted, int index) {
    return Padding(
        padding: EdgeInsets.only(left: 1.0, right: 5.0, top: 10.0),
        child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: index,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                  image: NetworkImage(imgPath),
                                  fit: BoxFit.cover)),
                          height: 100.0,
                          width: 100.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productName,
                            style: TextStyle(
                                fontFamily: 'Montserrat-bold',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: <Widget>[
                            Text('Qnt:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(quantity.toString(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 15.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5.0,
                            )
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Row(
                          children: <Widget>[
                            Text('Total:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(total.toString() + ' DZD',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 15.0,
                                    color: Colors.green[300])),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Livré:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(deliveryTime.toString().substring(0, 16),
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.grey[500])),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Statut:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 14.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5,
                            ),
                            isCompleted
                                ? Text('Livré',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat-bold',
                                        fontSize: 14.0,
                                        color: Colors.green[300]))
                                : Text('En attente',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat-bold',
                                        fontSize: 14.0,
                                        color: Colors.red[300])),
                          ],
                        )
                      ])
                ])),
                isCompleted
                    ? IconButton(
                        icon: Icon(Icons.check_circle_outline),
                        color: Colors.green[300],
                        onPressed: () {})
                    : IconButton(
                        icon: Icon(Icons.warning),
                        color: Colors.red[300],
                        onPressed: () {})
              ],
            )));
  }

  Widget _loadingDataAnimation() {
    return Shimmer.fromColors(
        child: ListView(
          //primary: false,
          //padding: EdgeInsets.only(left: 55.0, right: 40.0),
          children: <Widget>[
            SizedBox(
              height: 35.0,
            ),
            _animationItem(),
            SizedBox(
              height: 13.0,
            ),
            _animationItem(),
            SizedBox(
              height: 13.0,
            ),
            _animationItem(),
            SizedBox(
              height: 13.0,
            ),
            _animationItem(),
            SizedBox(
              height: 13.0,
            ),
            _animationItem(),
            SizedBox(
              height: 13.0,
            ),
            _animationItem()
          ],
        ),
        baseColor: Colors.grey[400],
        highlightColor: Colors.grey[500]);
  }

  Widget _animationItem() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25.0),
              ),
              height: 100.0,
              width: 100.0),
          SizedBox(width: 5.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 12.0,
                  width: 100.0),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 12.0,
                  width: 220.0),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 12.0,
                  width: 230),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 12.0,
                  width: 150.0),
            ],
          )
        ]));
  }
}
