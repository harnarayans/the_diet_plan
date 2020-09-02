import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final title;
  Chips({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Container(
        width: MediaQuery.of(context).size.width/3 -10,
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: TextStyle(
                color: Color(0XFFE1D7D7),
                fontSize: 14
            ),),
            Icon(Icons.close),
          ],
        ),
        color: Color(0XFF565252),
      ),
    );
  }
}
