import 'package:budgetmate/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import 'widgets/payment_listile.dart';

class PaymentListPage extends StatelessWidget {
  const PaymentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        title: const Text('Payment List'),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Column(
              children: [
                /* Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15),
                  child: const Text(
                    'All Expenses',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ), */
                /* Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 7,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffD9D9D9),
                  ),
                ), */
                /* Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff929292))),
                  child: SizedBox(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search for expense',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        icon: Icon(
                          Icons.search,
                          size: 28,
                        ),
                      ),
                      onChanged: (value) => _searchExpense(value),
                    ),
                  ),
                ), */
              ],
            ),
            Flexible(
                fit: FlexFit.tight,
                child: AntiListGlowWrapper(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return PaymentListTile(title: categories[index]);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
