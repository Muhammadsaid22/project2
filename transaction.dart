import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String nomi;
  final double narxi;
  final DateTime vaqti;

  Transaction({
    @required this.id,
    @required this.nomi,
    @required this.narxi,
    @required this.vaqti,
  });
}