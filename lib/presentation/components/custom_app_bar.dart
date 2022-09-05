import 'package:flutter/material.dart';

class CustomAppBar extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var firstStartPoint = Offset( size.width / 24  , size.height - 105);
    var firstEndPoint = Offset(size.width / 4   , size.height  - 100);
    path.quadraticBezierTo(
      firstStartPoint.dx - 10,
      firstStartPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    var secStartPoint = Offset( size.width / 2 , size.height - 100);
    var secEndPoint = Offset( size.width / 2, size.height - 100);
    path.quadraticBezierTo(
      secStartPoint.dx   ,
      secStartPoint.dy  ,
      secEndPoint.dx ,
      secEndPoint.dy ,
    );
    var thirdStartPoint = Offset((3 * size.width) / 4 , size.height - 100);
    var thirdEndPoint = Offset((3 * size.width) / 4, size.height - 100);
    path.quadraticBezierTo(
      thirdStartPoint.dx   ,
      thirdStartPoint.dy  ,
      thirdEndPoint.dx ,
      thirdEndPoint.dy ,
    );
    var quadStartPoint = Offset( size.width , size.height - 100);
    var quadEndPoint = Offset( size.width , size.height - 180);
    path.quadraticBezierTo(
      quadStartPoint.dx   ,
      quadStartPoint.dy  ,
      quadEndPoint.dx ,
      quadEndPoint.dy ,
    );
    path.lineTo(
      size.width,
      0,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}
