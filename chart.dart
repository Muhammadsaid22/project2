import 'package:note/Widjets/chart_bart.dart';
import 'package:flutter/material.dart';
import 'package:note/modules/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrs;

  Chart(this.recentTrs);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for(var i=0; i<recentTrs.length; i++)
      {
        if(recentTrs[i].vaqti.day == weekDay.day &&
            recentTrs[i].vaqti.month == weekDay.month &&
            recentTrs[i].vaqti.year == weekDay.year)
        {
          totalSum+=recentTrs[i].narxi;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) => sum+item['amount']);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending==0.0? 0.0 : (data['amount'] as double)/ totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
