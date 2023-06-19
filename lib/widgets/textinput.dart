import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isNumber;
  final void Function(String)? onSubmitted;

  const UserInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isNumber,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(26, 105, 105, 105),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          autofocus: isNumber ? false : true,
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          textInputAction:
              isNumber ? TextInputAction.send : TextInputAction.next,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(120, 44, 49, 64),
              fontWeight: FontWeight.w200,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
