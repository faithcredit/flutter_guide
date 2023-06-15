import './chart_bar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date?.day == weekDay.day &&
              recentTransactions[i].date?.month == weekDay.month &&
              recentTransactions[i].date?.year == weekDay.year) {
            totalSum += recentTransactions[i].amount ?? 0.0;
          }
        }

        print(DateFormat.E().format(weekDay).substring(0, 1));
        print(totalSum);
        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (double sum, item) {
      return sum + (item['amount'] as double?)!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionValues.map((data) {
              // return Text('${data['day']} : ${data['amount']}');
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }),
          ],
        ),
      ),
    );
  }
}
