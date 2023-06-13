import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onSave;
  final void Function()? onCancel;
  const BottomSheetContent({
    super.key,
    this.controller,
    this.onSave,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return addContentsDialog();
  }

  Widget clearContentsDialog() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          /* borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ), */
          ),
      child: const Center(
        child: Text('This is a Bottom Sheet'),
      ),
    );
  }

  Widget addContentsDialog() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            inputTextField(controller),
            inputTextField(controller),
            inputTextField(controller),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onSave,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget inputTextField(TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: true,
        controller: controller,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          /*  if (value.length > 30) {
                      setState(() {
                        errorText = 'Max of 30 characters!';
                        buttonEnabled = false;
                      });
                    } else {
                      setState(() {
                        errorText = null;
                        buttonEnabled = true;
                      });
                    } */
        },
        decoration: const InputDecoration(
          iconColor: Color(0xffe8eeff),
          hintText: 'Add New',
          hintStyle: TextStyle(
            color: Color(0xffe8eeff),
          ),
          //errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffaabdf8)), // Set the desired border color
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xffe8eeff),
        ),
      ),
    );
  }
}
