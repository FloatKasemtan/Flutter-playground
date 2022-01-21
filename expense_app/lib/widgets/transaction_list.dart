import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transaction
                .map((tx) => TransactionCard(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: deleteTransaction,
                    ))
                .toList(),

            // Maximillian style
            // Card(
            //   elevation: 4,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       backgroundColor: Theme.of(context).primaryColor,
            //       radius: 30,
            //       child: Padding(
            //         padding: const EdgeInsets.all(6),
            //         child: FittedBox(
            //             child: Text(
            //           '\$${transaction[index].amount}',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold, color: Colors.white),
            //         )),
            //       ),
            //     ),
            //     title: Text(
            //       transaction[index].title,
            //       style: Theme.of(context).textTheme.bodyText1,
            //     ),
            //     subtitle: Text(
            //         DateFormat.yMMMd().format(transaction[index].date)),
            //   ),
            // );
          );
  }
}
