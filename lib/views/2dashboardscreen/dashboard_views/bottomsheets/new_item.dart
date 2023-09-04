import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewBudgetBS extends StatelessWidget {
  final Function newBudget;
  const AddNewBudgetBS({super.key, required this.newBudget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () => newBudget(context),
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/images/budget.svg',
                  fit: BoxFit.contain,
                  height: 45,
                ),
              ),
              title: Text(
                'Create a new budget',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                'Add a new budget with spending items',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
