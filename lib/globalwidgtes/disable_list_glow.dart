import 'package:flutter/material.dart';

class AntiListGlowWrapper extends StatelessWidget {
  final Widget child;

  const AntiListGlowWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator(); // Disable the blue glow effect
        return false;
      },
      child: child,
    );
  }
}
