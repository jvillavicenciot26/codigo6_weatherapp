import 'package:flutter/material.dart';

class ItemForeCastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 12.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Text(
            "12 AM",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Icon(
            Icons.cloud_queue,
            size: 26.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            "23° C",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
