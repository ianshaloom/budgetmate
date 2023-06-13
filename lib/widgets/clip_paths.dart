import 'package:flutter/material.dart';

class DrawClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.30);
    path.cubicTo(
      size.width / 4,
      size.height,
      3 * size.width / 4,
      size.height / 2,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the bottom-left corner
    path.moveTo(0, size.height - 30);

    // Draw a line to the top-left corner
    path.lineTo(0, 30);

    // Draw a quadratic Bezier curve to the top-left rounded corner
    path.quadraticBezierTo(0, 0, 30, 0);

    // Draw a line to the top-right corner
    path.lineTo(size.width - 30, 0);

    // Draw a quadratic Bezier curve to the top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, 30);

    // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height - 30);

    // Draw a quadratic Bezier curve to the bottom-right rounded corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - 30, size.height);

    // Draw a line to the bottom-left corner
    path.lineTo(30, size.height);

    // Draw a quadratic Bezier curve to the bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 30);

    // Close the path to form a complete shape
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
