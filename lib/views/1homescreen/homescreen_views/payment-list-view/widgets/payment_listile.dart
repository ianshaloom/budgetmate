import 'package:budgetmate/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentListTile extends StatelessWidget {
  final String title;
  const PaymentListTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
          context, '/home_page/paymentlist_page/payment_page/',
          arguments: [fileName(title)!, title]),
      contentPadding: const EdgeInsets.all(8),
      leading: Hero(
        tag: fileName(title)!,
        child: CircleAvatar(
          radius: 45,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            fileName(title)!,
            fit: BoxFit.contain,
            height: 50,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
