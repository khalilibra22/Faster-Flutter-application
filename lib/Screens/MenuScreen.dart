import 'package:Faster/Screens/splashScreen.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:Faster/Screens/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'StoresScreen.dart';
import 'OrdersScreen.dart';
import 'UserAccountScreen.dart';
//import 'mHomeScreen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  SharedPreferences _prefs;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryGreen,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 20.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    bool isInstalled = await DeviceApps.isAppInstalled(
                        'com.example.FasterBusiness');
                    if (isInstalled)
                      DeviceApps.openApp('com.example.FasterBusiness');
                  },
                  child: Text(
                    'FASTER business',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(167, 187, 187, 0.8),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat-bold'),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(167, 187, 187, 0.8),
                    size: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Accueil',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StoresPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store,
                        color: Color.fromRGBO(167, 187, 187, 0.8),
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Boutiques',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(167, 187, 187, 0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OrdersPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list,
                        color: Color.fromRGBO(167, 187, 187, 0.8),
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Commandes',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(167, 187, 187, 0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color.fromRGBO(167, 187, 187, 0.8),
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Compte',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(167, 187, 187, 0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              _prefs = await SharedPreferences.getInstance();
              _prefs.remove('token');

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LaunchScreen()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 8.0, bottom: 120.0),
              child: Row(
                children: [
                  Icon(Icons.chevron_left,
                      size: 18, color: Color.fromRGBO(167, 187, 187, 0.8)),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Déconnexion',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Color.fromRGBO(167, 187, 187, 0.8),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
