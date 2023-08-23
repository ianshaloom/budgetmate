import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMenu extends StatefulWidget {
  final Function object;
  final List<String> names;
  const MyMenu({super.key, required this.object, required this.names});

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            'Select Spending',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownMenu<String>(
            trailingIcon: const Icon(CupertinoIcons.chevron_down),
            width: 150,
            menuHeight: 300,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            onSelected: (value) => widget.object(value!),

            // Text Decorations
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),

            // Menu Decorations
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xffF2F2FA),
              ),
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),

            // DropDown Menu Entries
            dropdownMenuEntries: widget.names.map((String value) {
              print(value);
              return DropdownMenuEntry(
                value: value,
                label: value,
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 15,
                      color: Color(0xff2c3140),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(),
      child: Container(
        color: Colors.orange,
      ),
    );
  }
}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 50); // Move to the starting point
    path.lineTo(0, size.height); // Line to the bottom-left corner
    path.lineTo(size.width, size.height); // Line to the bottom-right corner
    path.lineTo(size.width, 100); // Line to the top-right corner
    path.quadraticBezierTo(
        size.width / 2, 0, 0, 100); // Add a curve to the top-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/* class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
} */
