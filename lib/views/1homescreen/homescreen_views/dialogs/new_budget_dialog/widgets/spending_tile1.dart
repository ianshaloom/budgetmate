import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../models/budget-models/budgetmodel/budget.dart';

class SpendingTile1 extends StatelessWidget {
  final int index;
  final SpendingModel bsi;
  final Function delete;

  const SpendingTile1(
      {super.key,
      required this.index,
      required this.bsi,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          'assets/images/spending.svg',
          fit: BoxFit.contain,
          height: 45,
        ),
      ),
      title: Text(
        bsi.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        'Ksh. ${bsi.spendingAmount.toString()}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: IconButton(
        onPressed: () => delete(index, bsi),
        icon: const Icon(
          CupertinoIcons.delete,
          color: Color(0xffC10000),
        ),
      ),
    );
  }
}
