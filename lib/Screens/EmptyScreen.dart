import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.grey[500],
            child: Icon(
              Icons.grid_off,
              size: 80,
              color: Colors.grey[400],
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.grey[500],
          child: Text("Il n' y a pas des commandes",
              style: TextStyle(
                  fontFamily: 'Montserrat-bold',
                  fontSize: 16.0,
                  color: Colors.blue)),
        ),
      ],
    );
  }
}
