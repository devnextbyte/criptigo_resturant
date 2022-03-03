import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepo {
  static final instance = AppRepo();

  Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("CRIPT_PIN", pin);
  }

  Future<String> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    final pin = prefs.getString("CRIPT_PIN");
    return pin == null || pin.isEmpty ? "0000" : pin;
  }

  void saveSettings({
    @required String btcAddress,
    @required String ltcAddress,
    // @required String xmrAddress,
    @required String ethAddress,
    @required String deviceId,
  }) async {
    print("saving $btcAddress");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("CRIPT_DEVICE_ID", deviceId);

    await prefs.setString("CRIPT_BTC_KEY", btcAddress);
    await prefs.setString("CRIPT_LTC_KEY", ltcAddress);
    // await prefs.setString("CRIPT_XMR_KEY", xmrAddress);
    await prefs.setString("CRIPT_ETH_KEY", ethAddress);
  }

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("CRIPT_DEVICE_ID");
  }

  Future<String> getBtcAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("CRIPT_BTC_KEY");
  }

  Future<String> getXmrAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("CRIPT_XMR_KEY");
  }

  Future<String> getLtcAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("CRIPT_LTC_KEY");
  }

  Future<String> getEthAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("CRIPT_ETH_KEY");
  }
}
