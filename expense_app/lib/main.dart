import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // This lines is for setting the app PreferredOrientations
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink[300],
        errorColor: Colors.red,
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((e) {
      return e.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction =
        Transaction(title: title, amount: amount.toDouble(), date: date);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
          );
    final calculatedMediaHeight =
        mediaQuery.size.height - /* Original Media Height */
            mediaQuery.padding.top - /* Status Bar Height */
            appBar.preferredSize.height; /* Appbar height */

    final txListWiddget = Container(
        height: calculatedMediaHeight * .7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show Chart',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Switch.adaptive(
                        // .adaptive make running the app on different platform ex: ios use ios switch style
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        })
                  ],
                ),
              if (!isLandscape)
                Container(
                    height: calculatedMediaHeight * .3,
                    child: Chart(_recentTransactions)),
              if (!isLandscape) txListWiddget,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: calculatedMediaHeight * .7,
                        child: Chart(_recentTransactions))
                    : txListWiddget,
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
