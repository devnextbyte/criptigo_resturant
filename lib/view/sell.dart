import 'package:criptigo/repo/app_repo.dart';
import 'package:criptigo/view/reuseable/criptigo_app_bar.dart';
import 'package:criptigo/view/enter_amount.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:criptigo/view/reuseable/dash_button.dart';
import 'package:flutter/material.dart';

class Sell extends StatelessWidget {
  const Sell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: criptigoAppBar(title: "Sell"),
        body: Column(
          children: [
            SizedBox(height: 80),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DashButton(
                "assets/images/btc.png",
                "Bitcoin",
                () async {
                  final address = await AppRepo.instance.getBtcAddress();
                  if (address != null && address.isNotEmpty) {
                    push(context, EnterAmount(title: "Bitcoin"));
                  } else {
                    snack(context, "Please provide BTC Address in settings");
                  }
                },
              ),
              DashButton(
                "assets/images/ltc.png",
                "Litecoin",
                () async {
                  final address = await AppRepo.instance.getLtcAddress();
                  if (address != null && address.isNotEmpty) {
                    push(context, EnterAmount(title: "Litecoin"));
                  } else {
                    snack(context, "Please provide LTC Address in settings");
                  }
                },
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DashButton(
                "assets/images/eth.png",
                "Ethereum",
                () async {
                  final address = await AppRepo.instance.getEthAddress();
                  if (address != null && address.isNotEmpty) {
                    push(context, EnterAmount(title: "Ethereum"));
                  } else {
                    snack(context, "Please provide ETH Address in settings");
                  }
                },
              ),
              // SizedBox(),
              // SizedBox(width: MediaQuery.of(context).size.width / 5),
              // DashButton(
              //   "assets/images/xmr.png",
              //   "Monero",
              //   () async {
              //     final address = await AppRepo.instance.getXmrAddress();
              //     if (address != null && address.isNotEmpty) {
              //       push(context, EnterAmount(title: "Monero"));
              //     } else {
              //       snack(context, "Please provide XMR Address in settings");
              //     }
              //   },
              // ),
            ]),
          ],
        ),
      ),
    );
  }
}
