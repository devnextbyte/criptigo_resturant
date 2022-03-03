import 'package:criptigo/repo/app_repo.dart';
import 'package:criptigo/model/bill_model.dart';
import 'package:criptigo/repo/balance_repo.dart';
import 'package:criptigo/repo/bill_repo.dart';
import 'package:criptigo/view/reuseable/criptigo_app_bar.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:flutter/material.dart';

class EnterAmount extends StatefulWidget {
  final String title;

  const EnterAmount({Key key, this.title}) : super(key: key);

  @override
  _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  List<TextEditingController> amounts = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: criptigoAppBar(title: widget.title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getAddItemHeading(),
            Expanded(
              flex: 2,
              child: ListView(
                children: amounts.map((e) => getAmountInputItem(e)).toList(),
              ),
            ),
            getTotalView(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  showProgressDialog();
                  await BillRepo.instance.sendBill(
                    await AppRepo.instance.getDeviceId(),
                    BillModel(
                      amountUsd: getTotal(),
                      amountCript: await getCript(getTotal()),
                      criptCurr: widget.title,
                      address: await getAddress(widget.title),
                    ),
                  );
                  pop(context);
                  showDoneDialogue();
                },
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> getCript(double netUsd) async {
    final rate = await BalanceRepo.instance.getRate(getSymbol(widget.title));
    return netUsd / rate;
  }

  Future<String> getAddress(String name) {
    if (name == "Bitcoin") {
      return AppRepo.instance.getBtcAddress();
    } else if (name == "Litecoin") {
      return AppRepo.instance.getLtcAddress();
    } else if (name == "Ethereum") {
      return AppRepo.instance.getEthAddress();
    } else if (name == "Monero") {
      return AppRepo.instance.getXmrAddress();
    } else {
      return Future.value("");
    }
  }

  String getSymbol(String name) {
    if (name == "Bitcoin") {
      return "BTC";
    } else if (name == "Litecoin") {
      return "LTC";
    } else if (name == "Ethereum") {
      return "ETH";
    } else if (name == "Monero") {
      return "XMR";
    } else {
      return "";
    }
  }

  Widget getAddItemHeading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Items",
          style: Theme.of(context).textTheme.headline5,
        ),
        OutlinedButton.icon(
          onPressed: () => setState(() {
            amounts.add(TextEditingController());
            amounts = amounts;
          }),
          label: Text("Add Item"),
          icon: Icon(Icons.add_circle_outline),
        )
      ]),
    );
  }

  Widget getAmountInputItem(TextEditingController e) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 4),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.cancel_outlined,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  amounts.remove(e);
                  amounts = amounts;
                });
              }),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: e,
              textAlign: TextAlign.end,
              onSubmitted: (v) {
                setState(() {
                  amounts = amounts;
                });
              },
              decoration: InputDecoration(
                hintText: "Enter Item Price",
              ),
            ),
          ),
          SizedBox(width: 8),
          Text("\$", style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }

  Widget getTotalView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  getTotalRow("Total", "${getTotal().toStringAsFixed(2)} \$",
                      bold: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTotalRow(String leading, String trailing, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.only(top: bold ? 24 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            trailing,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  void showProgressDialog() {
    showDialog(
        context: context,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 2,
                height: MediaQuery.of(context).size.height / 5,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey.shade400,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.grey),
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  void showDoneDialogue() {
    showDialog(
        context: context,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 2,
                height: MediaQuery.of(context).size.height / 5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            value: 100,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                            strokeWidth: 20,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  double getTotal() {
    return amounts.fold(0, (previousValue, element) {
      final thisAmount = element.text.isEmpty ? "0" : element.text;
      return previousValue += double.parse(thisAmount);
    });
  }
}
