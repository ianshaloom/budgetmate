import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../models/hive/boxes.dart';
import '../../../../data/views_data.dart';

class SpendingDetailedPage extends StatelessWidget {
  SpendingDetailedPage({super.key});
  final ValueNotifier<double> _valueNotifier = ValueNotifier(00);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spending = ModalRoute.of(context)!.settings.arguments as List;
    final int id = spending[0];
    final SpendingModel sp = spending[1];
    final Color color = spending[2];

    /* _spendings = _spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<Spending>(); */

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: Text(
          sp.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 19,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.filter),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: id,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 150,
                      width: 150,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1.3, // width ÷ height
                        valueNotifier: _valueNotifier,
                        progress: SpendingViewData().sPamountSpent(sp),
                        maxProgress: sp.spendingAmount,
                        corners: StrokeCap.butt,
                        foregroundColor: color,
                        backgroundColor:
                            const Color.fromARGB(45, 105, 105, 105),
                        foregroundStrokeWidth: 15,
                        backgroundStrokeWidth: 15,
                        animation: true,
                        child: Center(
                          child: Text(
                            '${((SpendingViewData().sPamountSpent(sp)) / (sp.spendingAmount) * 100).toStringAsFixed(1)} %',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff0071FF).withOpacity(0.3),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder(),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size.fromRadius(25))),
                            child: SvgPicture.asset(
                              'assets/images/add.svg',
                              fit: BoxFit.contain,
                              height: 25,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder(),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size.fromRadius(25))),
                            child: SvgPicture.asset(
                              'assets/images/edit.svg',
                              fit: BoxFit.contain,
                              height: 25,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder(),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size.fromRadius(25))),
                            child: SvgPicture.asset(
                              'assets/images/delete.svg',
                              fit: BoxFit.contain,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Expenses',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              '/budget_detail_page/budget_expenses_page',
                              arguments: spending),
                          child: const Text(
                            'Clear All',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Spendings List
                    Flexible(
                      fit: FlexFit.loose,
                      child: ValueListenableBuilder(
                        //----------------------------------------- ValueListenableBuilder
                        valueListenable: Boxes.expenseBox().listenable(),
                        builder: (context, box, _) {
                          // reversed list of spendings
                          var ex = box.values.toList().reversed;
                          // new list with matchind sp and bg IDS
                          List<ExpenseModel> expenses = ex
                              .where((element) => element.ids[1] == sp.ids[1])
                              .toList()
                              .cast<ExpenseModel>();

                          // return List
                          return expenses.isEmpty
                              ? Center(
                                  child: SvgPicture.asset(
                                    'assets/images/add.svg',
                                    fit: BoxFit.contain,
                                    height: 60,
                                  ),
                                )
                              : AntiListGlowWrapper(
                                  child: ListView.builder(
                                    itemCount: expenses.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: _expenseTile(
                                            context, expenses[index]),
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final DateFormat formatter = DateFormat('HH:mm');
  Widget _expenseTile(BuildContext ctx, ExpenseModel exp) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      height: 72,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: const Color(0xff0071FF).withOpacity(0.1),
                  child: SvgPicture.asset(
                    exp.category,
                    fit: BoxFit.contain,
                    height: 43,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Text(
                            exp.expenseName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${DateFormat.d().format(exp.date)} ${DateFormat.MMM().format(exp.date)}    •  ${formatter.format(exp.date)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff929292),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      NumberFormat('#,##0.00').format(exp.amountSpent),
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(ctx).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
