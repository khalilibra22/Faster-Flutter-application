import 'dart:io';

import 'package:Faster/classes/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../classes/mSystem.dart';
import 'package:shimmer/shimmer.dart';
import 'configuration.dart';

class StoresPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StoresPage> {
  bool isLoading = true;
  @override
  void initState() {
    _returnedData().then((value) => this._changeScreen());
    super.initState();

    //bool IsRegistred =  mSystemLocator().getUserInfo();
  }

  void _changeScreen() {
    setState(() {
      isLoading = false;
    });
  }

  Future _returnedData() async {
    bool likedStores = await mSystemLocator().getLikedStores();
    bool gpsStores = await mSystemLocator().getStoresUsingGps();
    bool storesCollection = await mSystemLocator().getStoresCollection();
  }

  Future _dislikeStore(int sellerId) async {
    bool dislike = await mSystemLocator().disLikeStore(sellerId);
  }

  Future _likeStore(int sellerId) async {
    bool dislike = await mSystemLocator().likeStore(sellerId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1428),
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
                Text('Stores',
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
                      child: isLoading ? _loadingDataAnimation() : _dataList(),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _dataList() {
    return ListView.builder(
        itemCount: mSystemLocator.stores.length,
        itemBuilder: (context, index) =>
            _buildFoodItem(mSystemLocator.stores[index], index));
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
        highlightColor: Colors.grey[300]);
  }

  Widget _buildFoodItem(Store mStore, int position) {
    bool likedStores = mStore.isLiked;
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () async {
              _bottomPopupSheet(context);
              if (likedStores) {
                await _dislikeStore(mStore.id);
                setState(() {
                  mStore.isLiked = false;
                });
              } else {
                await _likeStore(mStore.id);
                setState(() {
                  mStore.isLiked = true;
                });
              }
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: position,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(mStore.imgUrl ??
                                      'https://ccivr.com/wp-content/uploads/2019/07/empty-profile.png'),
                                  fit: BoxFit.cover)),
                          height: 70.0,
                          width: 70.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mStore.storeName,
                            style: TextStyle(
                                fontFamily: 'Montserrat-bold',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Container(
                          width: 170,
                          child: Text(mStore.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                        Row(
                          children: <Widget>[
                            Text('Livraison dans:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.black)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(mStore.deliveryTime.toString() + ' h',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Colors.green[600])),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Color(0xFFFFBC00),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(mStore.rating.toString(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat-bold',
                                    fontSize: 13.0,
                                    color: Color(0xFFFFBC00))),
                          ],
                        )
                      ])
                ])),
                likedStores
                    ? IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.red,
                        onPressed: () {})
                    : IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.grey,
                        onPressed: () {})
              ],
            )));
  }

  Widget _animationItem() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 70.0,
              width: 70.0),
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

  void _bottomPopupSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                  color: Color(0x00FFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Container(
                child: SpinKitRing(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ));
        });
  }
}
