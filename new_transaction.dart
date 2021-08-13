import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function adding;

  NewTransaction(this.adding);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _nomController = TextEditingController();
  final _pulController = TextEditingController();
  DateTime _selectDate;

  void _submitData(){
    if(_pulController.text.isEmpty)
    {
      return;
    }
    final enteredTitle =  _nomController.text;
    final enteredAmount =  double.parse(_pulController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 || _selectDate ==null)
    {
      return;
    }
    widget.adding(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker()
  {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2032),
    ).then((pickedDate) {
      if(pickedDate==null)
      {
        return;
      }
      setState(() {
        _selectDate=pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _nomController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: _pulController,
                onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          _selectDate==null ?
                          'No date chosen' :
                          'Selected date: ${DateFormat.yMd().format(_selectDate)}'
                      ),
                    ),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Choose date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        )
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                textColor: Colors.indigo,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
