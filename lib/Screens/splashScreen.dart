import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';
import 'MenuScreen.dart';
import '../Animations/FadeAnimation.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      bool isToken = false;
      _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString('token') ?? '';

      if (token != '') isToken = true;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NextWidget(isToken)));
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      Text(
                        'F',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      Text(
                        'A',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.6,
                      Text(
                        'S',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.8,
                      Text(
                        'T',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2,
                      Text(
                        'E',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2.2,
                      Text(
                        'R',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat-bold',
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget NextWidget(bool ExistToken) {
    if (ExistToken)
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: Stack(
            children: [DrawerScreen(), HomeScreen()],
          ),
        ),
      );
    return LoginScreen();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Etes-vous sûr ?',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontFamily: 'Montserrat-bold',
                letterSpacing: 1,
              ),
            ),
            content: new Text(
              'Voulez-vous vraiment quitter ?',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontFamily: 'Montserrat-bold',
                letterSpacing: 0,
              ),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.red[400],
                    fontFamily: 'Montserrat-bold',
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              new GestureDetector(
                onTap: () => exit(0) /* Navigator.of(context).pop(true) */,
                child: Text(
                  "OUI   ",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.blue,
                    fontFamily: 'Montserrat-bold',
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
