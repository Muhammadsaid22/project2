import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spenfingPctofTotal;

  ChartBar(this.label, this.spendingAmount, this.spenfingPctofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints){
        return Column(
          children: [
            Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
            ),
            SizedBox(
                height: constraints.maxHeight*0.03),
            Container(
              height: constraints.maxHeight*0.64,
              width: 13,
              child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spenfingPctofTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
                height: constraints.maxHeight*0.03),
            Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(
                  child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
