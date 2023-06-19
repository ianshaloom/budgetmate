import 'package:flutter/material.dart';

class DrawClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the bottom-left corner
    path.moveTo(0, size.height - 20);

    // Draw a line to the top-left corner
    path.lineTo(0, 85); // Adjusted to 75 for increased top-left clipping

    // Draw a quadratic Bezier curve to the top-left rounded corner
    path.quadraticBezierTo(0, 0, 90, -3);

    // Draw a line to the top-right corner
    path.lineTo(size.width - 20, 0);

    // Draw a quadratic Bezier curve to the top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height - 20);

    // Draw a quadratic Bezier curve to the bottom-right rounded corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - 20, size.height);

    // Draw a line to the bottom-left corner
    path.lineTo(20, size.height);

    // Draw a quadratic Bezier curve to the bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    // Close the path to form a complete shape
    path.close();

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
    path.moveTo(0, size.height - 20);

    // Draw a line to the top-left corner
    path.lineTo(0, 20);

    // Draw a quadratic Bezier curve to the top-left rounded corner
    path.quadraticBezierTo(0, 0, 20, 0);

    // Draw a line to the top-right corner
    path.lineTo(size.width - 20, 0);

    // Draw a quadratic Bezier curve to the top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height - 20);

    // Draw a quadratic Bezier curve to the bottom-right rounded corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - 20, size.height);

    // Draw a line to the bottom-left corner
    path.lineTo(20, size.height);

    // Draw a quadratic Bezier curve to the bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    // Close the path to form a complete shape
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
