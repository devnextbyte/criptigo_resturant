import 'package:criptigo/repo/app_repo.dart';
import 'package:criptigo/repo/balance_repo.dart';
import 'package:criptigo/view/reuseable/balance_view.dart';
import 'package:criptigo/view/reuseable/criptigo_app_bar.dart';
import 'package:criptigo/view/reuseable/dash_button.dart';
import 'package:criptigo/view/reuseable/enter_pin_view.dart';
import 'package:criptigo/view/sell.dart';
import 'package:criptigo/view/settings.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final showBalance = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: criptigoAppBar(withBack: false),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getBalanceWidget(context),
              getDashButtons(context),
              SizedBox(),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBalanceWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Balance",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: showBalance,
                builder: (context, val, child) => showBalance.value
                    ? getCryptoBalances(context)
                    : Text("****",
                        style: Theme.of(context).textTheme.headline4),
              ),
            ],
          ),
        ),
        IconButton(
            icon: ValueListenableBuilder(
              valueListenable: showBalance,
              builder: (context, val, widget) => Icon(
                  val ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              showBalance.value = !showBalance.value;
            })
      ],
    );
  }

  Widget getCryptoBalances(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BalanceView(
            title: "BTC", balance: BalanceRepo.instance.getBtcBalance()),
        BalanceView(
            title: "ETH", balance: BalanceRepo.instance.getEthBalance()),
        BalanceView(
            title: "LTC", balance: BalanceRepo.instance.getLtcBalance()),
        // BalanceView(
        //     title: "XMR", balance: BalanceRepo.instance.getXmrBalance()),
      ]);

  Widget getDashButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashButton(
          "assets/images/sell.png",
          "Sell",
          () async {
            final deviceId = await AppRepo.instance.getDeviceId();
            if (deviceId == null) {
              snack(context, "Please set device id in settings first\n");
              return;
            }
            return push(context, Sell());
          },
        ),
        DashButton(
          "assets/images/settings.png",
          "Settings",
          () {
            showDialog(
              context: context,
              builder: (context) => EnterPinView(onApproved: () {
                push(context, Settings());
              }),
            );
          },
        ),
      ],
    );
  }

  Widget getDashButton(
      BuildContext context, String icon, String label, void Function() onTap) {
    final refWidth = MediaQuery.of(context).size.width / 5;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              Row(children: [
                Image.asset(
                  "assets/images/elipse.png",
                  width: refWidth,
                ),
                SizedBox(width: refWidth)
              ]),
              Positioned(
                right: 16,
                top: 16,
                child: Image.asset(icon, width: refWidth),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
