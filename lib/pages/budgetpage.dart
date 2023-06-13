import 'package:flutter/material.dart';

import '../widgets/clip_paths.dart';
import '../widgets/expensetile.dart';
import '../widgets/twobuttons.dart';

class BudgetPage extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onClear;
  const BudgetPage({
    super.key,
    required this.onAdd,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipPath(
            clipper: DrawClip2(),
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                color: Color(0xffaabdf8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(40),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(40),
                ),
              ),
              /* child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 60),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return const ExpenseTile(
                      pageIndex: 1,
                    );
                  },
                ),
              ), */
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: FloatingButtons(
              onAdd: onAdd,
              onClear: onClear,
              pageIndex: 0,
              totalAmount: '25,000',
            ),
          ),
        ],
      ),
    );
  }
}
