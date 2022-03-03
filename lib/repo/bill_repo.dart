import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptigo/model/bill_model.dart';

class BillRepo {
  static final instance = BillRepo();

  DocumentReference getBillStream(String deviceId) {
    return FirebaseFirestore.instance
        .collection("Bills")
        .doc(deviceId);
  }

  Future<void> sendBill(String deviceId, BillModel bill){
    print(bill.toJson());
    return getBillStream(deviceId).set(bill.toJson());
  }
}
