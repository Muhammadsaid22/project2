import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:note/modules/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTr;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this. deleteTr,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  /*
  Random Colors for amount Box border
  Color itemC;
  @override
  void initState() {
    const availableColors = [
      Colors.amberAccent,
      Colors.redAccent,
      Colors.lightGreenAccent,
      Colors.blueAccent
    ];
    itemC = availableColors[Random().nextInt(4)];
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: ListTile(
        leading: Container(
          height: 120,
          width: 80,
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 2,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey,
              )
          ),
          child: FittedBox(
            child: Text(
              '\$${widget.transaction.narxi.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title:   Text(
          widget.transaction.nomi,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle:   Text(
          DateFormat.yMMMd().format(widget.transaction.vaqti),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 500 ?
        FlatButton.icon(
            icon: Icon(Icons.delete_forever),
            textColor: Colors.redAccent,
            onPressed: () => widget.deleteTr(widget.transaction.id),
            label: Text('Delete'))
            :  IconButton(
          icon: Icon(Icons.delete_forever),
          color: Colors.redAccent,
          onPressed: () => widget.deleteTr(widget.transaction.id),
        ),
      ),
    );;
  }
}
