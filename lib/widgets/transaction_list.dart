import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
               Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/home.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          }))
        : ListView(children: 
          transactions.map((tx) => TransactionItem(
            key: ValueKey(tx.id),
            transaction: tx, 
            deleteTx: deleteTx)).toList()
        ,);
  }
}


