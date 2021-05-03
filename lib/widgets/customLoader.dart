import 'package:flutter/material.dart';

Widget customLoader(context) {
  return Container(
    color: Colors.grey[300],
    width: 70.0,
    height: 70.0,
    child: new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new Center(child: new CircularProgressIndicator())),
  );
}
