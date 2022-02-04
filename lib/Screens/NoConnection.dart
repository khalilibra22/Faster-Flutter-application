import 'package:Faster/Screens/splashScreen.dart';
import 'package:Faster/classes/mSystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class NoConnection extends StatefulWidget {
  @override
  _NoConnectionState createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey[500],
              highlightColor: Colors.grey[400],
              child: Icon(
                Icons.cloud_off,
                color: Colors.grey,
                size: 75.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Connexion impossible, Réessayer",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Montserrat-bold',
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 10.0),
            _isLoading
                ? SpinKitRing(
                    color: Colors.blue,
                    size: 40.0,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.blue,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      bool result = await mSystemLocator().checkConnection();

                      if (result) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LaunchScreen()));
                        return;
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}
