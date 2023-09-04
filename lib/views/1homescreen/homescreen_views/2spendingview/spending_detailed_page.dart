import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../data/data.dart';
import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../models/hive/boxes.dart';
import '../../../../data/views_data.dart';
import 'dialogs/edit_spending.dart';
import 'widgets/delete_spending.dart';
import 'widgets/expense_tile_sp.dart';

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
        title: ValueListenableBuilder(
          //----------------------------------------- ValueListenableBuilder
          valueListenable: Boxes.spendingBox().listenable(),
          builder: (context, box, _) {
            var s =
                GetMe.spendings.where((element) => element.ids[1] == id).first;

            return Text(
              s.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black),
            );
          },
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.filter),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ValueListenableBuilder(
                valueListenable: Boxes.expenseBox().listenable(),
                builder: (context, box, _) {
                  double totalSpent = SpendingViewData().sPamountSpent(sp);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 150,
                        width: 150,
                        child: DashedCircularProgressBar.aspectRatio(
                          aspectRatio: 1.3, // width ÷ height
                          valueNotifier: _valueNotifier,
                          progress: totalSpent,
                          maxProgress: sp.spendingAmount,
                          corners: StrokeCap.butt,
                          foregroundColor: color,
                          backgroundColor:
                              const Color.fromARGB(20, 105, 105, 105),
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
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 150,
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //
                        //
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  NumberFormat('#,##0.00').format(totalSpent),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total Spent',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.6),
                                    fontFamily: 'OpenSans',
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ValueListenableBuilder(
                                  //----------------------------------------- ValueListenableBuilder
                                  valueListenable:
                                      Boxes.spendingBox().listenable(),
                                  builder: (context, box, _) {
                                    var s = GetMe.spendings
                                        .where(
                                            (element) => element.ids[1] == id)
                                        .first;

                                    return Text(
                                      NumberFormat('#,##0.00')
                                          .format(s.spendingAmount),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'OpenSans',
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Spending Amount',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.6),
                                    fontFamily: 'OpenSans',
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xff0071FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                          onPressed: () => _editSpendingSD(context, sp),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => _deleteSpendingBS(context, sp),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            '/budget_detail_page/budget_expenses_page',
                            arguments: spending),
                        child: const Text(
                          'Clear all',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
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
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        color: Colors.white,
                                        child: ExpenseSpTile(
                                          expense: expenses[index],
                                        ));
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
    );
  }
  
  
     // Edit Budget Dialog
  Future _editSpendingSD(BuildContext cxt, SpendingModel spending) async {
    await showDialog(
      context: cxt,
      builder: (context) => EditSpendingSD(spending: spending),
    );
  }

  // Delete Budget BottomSheet
  Future _deleteSpendingBS(BuildContext cxt, SpendingModel spending) async {
    await showModalBottomSheet(
      context: cxt,
      builder: (context) => DeleteSpendingBS(
        spending: spending,
      ),
    );
  }

 
}
