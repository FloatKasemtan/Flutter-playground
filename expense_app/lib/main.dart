import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.pink[300],
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;
  final titleController = TextEditingController();

  // String amountInput;
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   title: 'New Shoes',
    //   amount: 69.99,
    // ),
    // Transaction(
    //   title: 'Weekly Groceries',
    //   amount: 16.99,
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((e) {
      return e.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(title: title, amount: amount.toDouble());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    print(_recentTransactions);
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
