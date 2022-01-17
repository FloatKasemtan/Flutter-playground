import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final List<Transaction> transactions;
  final int index;
  final Function deleteTransaction;

  TransactionCard(this.transactions, this.index, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      elevation: 2,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            // decoration:
            //     BoxDecoration(border: Border.all(color: Colors.blue)),
            padding: EdgeInsets.all(5),
            child: Text(
              '\$${transactions[index].amount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Container(
            child: MediaQuery.of(context).size.width > 360
                ? TextButton.icon(
                    onPressed: () => deleteTransaction(transactions[index].id),
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                  )
                : IconButton(
                    onPressed: () => deleteTransaction(transactions[index].id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
          )
        ],
      ),
    );
    ;
  }
}
