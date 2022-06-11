import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTitle {
   title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Re',
          children: [
            TextSpan(
              text: 'mind',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'er',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}
