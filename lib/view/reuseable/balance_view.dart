import 'package:criptigo/model/balance_model.dart';
import 'package:criptigo/repo/balance_repo.dart';
import 'package:flutter/cupertino.dart';

class BalanceView extends StatelessWidget {
  final String title;
  final Future<BalanceModel> balance;

  const BalanceView({Key key, @required this.title, @required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
            BalanceRepo.instance.getImageByTitle(title),
            width: 24,
            height: 24,
          )),
          SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: FutureBuilder<BalanceModel>(
              future: balance,
              builder: (context, state) {
                if (state.hasError) {
                  print("${state.error}");
                  return Text("${state.error}");
                } else if (state.data == null) {
                  return Text("...");
                } else {
                  return Text("${state.data.cript}");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
