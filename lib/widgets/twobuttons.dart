import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  final String totalAmount;
  final void Function()? onAdd;
  final void Function()? onClear;
  final int pageIndex;
  const FloatingButtons({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.pageIndex,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: size.width * 0.65,
          decoration: const BoxDecoration(
            color: Color.fromARGB(123, 131, 131, 131),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: onAdd,
                  shape: const CircleBorder(),
                  backgroundColor:  pageIndex == 0
                      ? const Color(0xffffa600)
                      : const Color(0xffaabdf8),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  mini: true,
                  onPressed: onClear,
                  shape: const CircleBorder(),
                  backgroundColor: pageIndex == 0
                      ? const Color(0xffffa600)
                      : const Color(0xffaabdf8),
                  child: const Icon(
                    Icons.clear_all_outlined,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Kshs. $totalAmount',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
