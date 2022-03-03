import 'package:criptigo/repo/balance_repo.dart';

void main() async {
  print("${await BalanceRepo.instance.getBtcBalance()}");
}
