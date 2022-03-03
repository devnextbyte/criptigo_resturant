import 'package:flutter/foundation.dart';

class BillModel {
  final double amountUsd;
  final double amountCript;
  final String criptCurr;
  final String address;

  BillModel({
    @required this.amountUsd,
    @required this.amountCript,
    @required this.criptCurr,
    @required this.address,
  });

  Map<String, dynamic> toJson() => {
        "amountUsd": amountUsd,
        "amountCript": amountCript,
        "criptCurr": criptCurr,
        "address": address,
      };
}
