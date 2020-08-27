import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/chart.dart';
import 'package:learn_flutter/widgets/new_transaction.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransactions(String title, double amount, DateTime selectedDate) {
    final newTx = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      this._userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_buildContext) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(
              addTransaction: _addNewTransactions,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show chart',
            style: Theme.of(context).textTheme.title,
          ),
          // if we use switch.adaptive, it will switch to things that specific to os
          // likes os
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: showChart,
              onChanged: (val) {
                setState(() {
                  showChart = val;
                });
              })
        ],
      ),
      showChart
          ? Container(
              width: double.infinity,
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Card(
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
                elevation: 5,
              ),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return <Widget>[
      Container(
        width: double.infinity,
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Card(
          child: Chart(
            recentTransactions: _recentTransactions,
          ),
          elevation: 5,
        ),
      ),
      txListWidget
    ];
  }

  bool showChart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => startNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => startNewTransaction(context)),
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: this._userTransactions,
        deleteTransaction: this.deleteTransaction,
      ),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      startNewTransaction(context);
                    },
                  ),
          );
  }
}
