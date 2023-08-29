import 'package:flutter/material.dart';

class DisplayOrateur extends StatelessWidget {
  const DisplayOrateur({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 100,
      margin: EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(
              top: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Text("Muanza K.."),
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Text(
              "Modérateur",
              style: TextStyle(fontSize: 12),
            ),
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Text("00:00"),
            height: 20,
          ),
        ],
      ),
    );
  }
}
