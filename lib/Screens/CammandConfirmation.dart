import 'package:Faster/Screens/HomePage.dart';
import 'package:Faster/Screens/splashScreen.dart';
import 'package:Faster/classes/mSystem.dart';
import 'package:Faster/config/CustomToast.dart';
import 'package:Faster/config/getUserLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'configuration.dart';

class CammandPage extends StatefulWidget {
  CammandPage() {}
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CammandPage> {
  final _recipientName = TextEditingController();
  final _recipientPhone = TextEditingController();
  final _recipientAddress = TextEditingController();

  bool isCammandWithLocation = true;
  bool _isCammandCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF9800),
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
                Text('Cammand',
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 55.0, right: 40.0),
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                ),
                InputWidget(
                    'Nom Complet',
                    'Entrer votre nom',
                    TextInputType.text,
                    Icon(
                      Icons.supervised_user_circle,
                      color: Colors.grey[500],
                    ),
                    false,
                    false,
                    _recipientName),
                SizedBox(
                  height: 10.0,
                ),
                InputWidget(
                    'N° Téléphone',
                    'Entrer votre N° de téléphone',
                    TextInputType.phone,
                    Icon(
                      Icons.phone_iphone,
                      color: Colors.grey[500],
                    ),
                    false,
                    false,
                    _recipientPhone),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Envoyer votre position (recomandé)',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadowList,
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 50.0,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: isCammandWithLocation,
                            activeColor: Color(0xFFFF9800),
                            onChanged: (value) {
                              setState(() {
                                isCammandWithLocation = value;
                              });
                            },
                          ),
                          Text(
                            'Position',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                InputWidget(
                    'Adresse',
                    'Entrer votre Adresse',
                    TextInputType.text,
                    Icon(
                      Icons.home,
                      color: Colors.grey[500],
                    ),
                    false,
                    isCammandWithLocation,
                    _recipientAddress),
                _saveBtn()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget InputWidget(String InputTypeTxt, String HintTxt, final InputType,
      final IconType, bool isPassword, bool ReadOnly, final controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          InputTypeTxt,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(10.0)),
          height: 50.0,
          child: TextField(
            controller: controller,
            readOnly: ReadOnly,
            obscureText: isPassword,
            keyboardType: InputType,
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey[500],
              fontFamily: 'Montserrat',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: IconType,
              hintText: HintTxt,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _saveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (!_inputValidation()) return;
          var lat = 0.0;
          var long = 0.0;
          var address = 'null';

          if (isCammandWithLocation) {
            /*Get user location from userLoction service  */
            GetUserLocation userPosition = GetUserLocation();
            await userPosition.grantPermission();
            //LocationData location = await userPosition.getLocation();
            lat = mSystemLocator.userLocation.latitude;
            long = mSystemLocator.userLocation.longitude;
          } else {
            if (_recipientAddress.text.length < 5) {
              mToast().errorMessage('Votre adresse est trés courte');
              return;
            }
            address = _recipientAddress.text;
          }
          _bottomPopupSheet(context);

          for (int i = 0; i < mSystemLocator.storeCart.length; i++) {
            List<Map> prods = List<Map>();
            for (int j = 0;
                j < mSystemLocator.storeCart[i].products.length;
                j++) {
              var item = Map();
              item['ProductId'] =
                  mSystemLocator.storeCart[i].products[j].prod.id;
              item['Quantity'] =
                  mSystemLocator.storeCart[i].products[j].quantity;
              prods.add(item);
            }
            bool isOrdered = await mSystemLocator().createOrder(
                mSystemLocator.storeCart[i].sellerId,
                _recipientName.text,
                _recipientPhone.text,
                address,
                lat,
                long,
                DateTime.now().toString(),
                prods,
                mSystemLocator.storeCart[i].notificationToken);
          }
          _clearFields();
          mSystemLocator.storeCart.clear();
          setState(() {
            _isCammandCompleted = true;
          });
          Navigator.pop(context);
          _bottomPopupSheet(context);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFFFF9800),
        child: Text(
          'Confirmer',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 17.0,
            //fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  bool _inputValidation() {
    if (_recipientName.text.length < 5) {
      mToast().errorMessage('le nom est trés court');
      return false;
    }
    if (_recipientPhone.text.length < 5) {
      mToast().errorMessage('Vérifier votre N° téléphone');
      return false;
    }
    return true;
  }

  void _bottomPopupSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 200.0,
            padding: EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: !_isCammandCompleted
                ? Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: SpinKitRing(
                            color: Colors.green,
                            size: 50.0,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            'Traitement en cours ...',
                            style: TextStyle(
                              color: Colors.grey[600],
                              letterSpacing: 1.5,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            'Cammande envoyer',
                            style: TextStyle(
                              color: Colors.green[600],
                              letterSpacing: 1.5,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LaunchScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.blue[600],
                                letterSpacing: 1.5,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  void _clearFields() {
    _recipientName.clear();
    _recipientPhone.clear();
    _recipientAddress.clear();
  }
}
