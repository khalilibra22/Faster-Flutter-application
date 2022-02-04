//import 'package:Faster/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadigWidgetState createState() => _LoadigWidgetState();
}

class _LoadigWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return LoadingData();
  }

  Widget LoadingData() {
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
                      child: SpinKitRing(
                    color: Colors.white,
                    size: 50.0,
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
