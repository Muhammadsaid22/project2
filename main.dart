import 'dart:io';
import 'package:note/Widjets/new_transaction.dart';
import 'package:note/Widjets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modules/transaction.dart';
import 'package:note/Widjets/chart.dart';
import 'package:flutter/services.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.black38,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold
            ),
          ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            ),)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [  ];
  bool _showChart = false;

  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print(state);
  }

  @override
  void dispose()
  {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.vaqti.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate)
  {
    final newTR = Transaction(
        id: DateTime.now().toString(),
        nomi: title,
        narxi: amount,
        vaqti: chosenDate);
    setState(() {
      _userTransactions.add(newTR);
    });
  }

  void _startAddNewTransaction(BuildContext ctx)
  {
    showModalBottomSheet(
        context: ctx,
        builder: (_)
        {
          return GestureDetector(
            child:  NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        }
    );
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List <Widget> _buildLandscapeContent(MediaQueryData mQ, AppBar apppBar, Widget TrsList)
  {
    return[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch(value: _showChart,
              onChanged: (val)
              {
                setState(() {
                  _showChart=val;
                });
              })
        ],
      ),
      _showChart ? Container(
          height: (mQ.size.height-
              apppBar.preferredSize.height-
              mQ.padding.top
          )*0.7,
          child: Chart(_recentTransactions))
          : TrsList,

    ];
  }
  List <Widget> _buildPortraitContent(MediaQueryData mQ, AppBar apppBar, Widget TrsList)
  {
    return[ Container(
        height: (mQ.size.height-
            apppBar.preferredSize.height-
            mQ.padding.top
        )*0.3,
        child: Chart(_recentTransactions)),
      TrsList,
    ];
  }


  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final isLandscape = mQ.orientation == Orientation.landscape;
    final PreferredSizeWidget apppBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: GestureDetector(
        child: Icon(CupertinoIcons.add),
        onTap: () => _startAddNewTransaction(context),
      ),
    )
        : AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton
          (icon: Icon(Icons.add_to_photos),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final TrsList = Container(
        height: (mQ.size.height-
            apppBar.preferredSize.height-
            mQ.padding.top
        )*0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
    );
    final PageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) ..._buildLandscapeContent(mQ, apppBar, TrsList),
            if(!isLandscape) ..._buildPortraitContent(mQ, apppBar, TrsList),

          ],
        ),
      ),
    );
    return Platform.isIOS ? CupertinoPageScaffold(
      child: PageBody,
      navigationBar: apppBar,) :
    Scaffold(
      backgroundColor: Colors.grey,
      appBar: apppBar,
      body: PageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}


