import 'package:criptigo/repo/app_repo.dart';
import 'package:criptigo/view/reuseable/criptigo_app_bar.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final currency = ValueNotifier(0);

  final btcAddress = TextEditingController();
  final ethAddress = TextEditingController();
  final ltcAddress = TextEditingController();
  // final xmrAddress = TextEditingController();

  final deviceId = TextEditingController();
  final pin = TextEditingController();
  final confirmPin = TextEditingController();

  @override
  void initState() {
    loadValues();
    super.initState();
  }

  void loadValues() async {
    final repo = AppRepo.instance;
    deviceId.text = await repo.getDeviceId();
    btcAddress.text = await repo.getBtcAddress();
    ltcAddress.text = await repo.getLtcAddress();
    ethAddress.text = await repo.getEthAddress();
    // xmrAddress.text = await repo.getXmrAddress();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: criptigoAppBar(title: "Settings"),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: btcAddress,
                          decoration: InputDecoration(
                            labelText: "BTC Address",
                            // suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: ltcAddress,
                          decoration: InputDecoration(
                            labelText: "LTC Address",
                            // suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: ethAddress,
                          decoration: InputDecoration(
                            labelText: "ETH Address",
                            // suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        // SizedBox(height: 16),
                        // TextField(
                        //   controller: xmrAddress,
                        //   decoration: InputDecoration(
                        //     labelText: "XMR Address",
                        //     // suffixIcon: Icon(Icons.lock),
                        //   ),
                        // ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        TextField(
                          controller: deviceId,
                          decoration: InputDecoration(
                            labelText: "QR Device Id",
                            suffixIcon: Icon(Icons.qr_code),
                          ),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        TextField(
                          controller: pin,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter New Pin",
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: confirmPin,
                          decoration: InputDecoration(
                            labelText: "Confirm New Pin",
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => showPinDialog(context),
                  child: Text("SAVE"),
                ),
              ],
            ),
          )),
    );
  }

  void showPinDialog(BuildContext context) {
    if (deviceId.text.isNotEmpty &&
        (!deviceId.text.startsWith("CRIPT") || deviceId.text.length != 10)) {
      snack(context, "Invalid device id");
      return;
    }

    if (pin.text.isNotEmpty && pin.text.length != 4) {
      snack(context, "Pin must be 4 digits");
      return;
    }

    if (pin.text != confirmPin.text) {
      snack(context, "Pin mismatch");
      return;
    }
    AppRepo.instance.saveSettings(
      btcAddress: btcAddress.text,
      deviceId: deviceId.text,
      ethAddress: ethAddress.text,
      ltcAddress: ltcAddress.text,
      // xmrAddress: xmrAddress.text,
    );
    if (pin.text.isNotEmpty) {
      AppRepo.instance.savePin(pin.text);
    }
    pop(context);
    pop(context);
  }
}
