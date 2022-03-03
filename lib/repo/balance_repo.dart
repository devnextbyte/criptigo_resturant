import 'package:criptigo/model/balance_model.dart';
import 'package:criptigo/repo/app_repo.dart';
import 'package:dio/dio.dart';

class BalanceRepo {
  static final instance = BalanceRepo();

  final _titleToImage = {
    "LTC": "assets/images/ltc.png",
    "BTC": "assets/images/btc.png",
    "ETH": "assets/images/eth.png",
    "XMR": "assets/images/xmr.png",
  };

  String getImageByTitle(String title) => _titleToImage[title];

  Future<BalanceModel> getBtcBalance() async {
    final btcAddr = await AppRepo.instance.getBtcAddress();
    if (btcAddr == null || btcAddr.isEmpty) {
      return Future.error("Address Not Found");
    }

    try {
      final resp = await Dio().get(
        "https://chainz.cryptoid.info/btc/api.dws?key=5358391f4eaa&q=getbalance&a=$btcAddr",
      );
      return BalanceModel(double.parse(resp.data), await getRate("BTC"));
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<BalanceModel> getLtcBalance() async {
    final ltcAddr = await AppRepo.instance.getLtcAddress();
    if (ltcAddr == null || ltcAddr.isEmpty) {
      return Future.error("Address Not Found");
    }
    try {
      final resp = await Dio().get(
          "https://chainz.cryptoid.info/ltc/api.dws?key=5358391f4eaa&q=getbalance&a=$ltcAddr");
      return BalanceModel(double.parse(resp.data), await getRate("LTC"));
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<BalanceModel> getEthBalance() async {
    final ethAddr = await AppRepo.instance.getEthAddress();
    if (ethAddr == null || ethAddr.isEmpty) {
      return Future.error("Address Not Found");
    }

    try {
      final resp = await Dio().get(
          "https://api.ethplorer.io/getAddressInfo/$ethAddr?apiKey=EK-9tM7W-kdzSqGS-msy7Q");
      return BalanceModel(resp.data['ETH']['balance'], await getRate("ETH"));
    } catch (e) {
      return _handleError(e);
    }
  }
  //
  // Future<BalanceModel> getXmrBalance() async {
  //   final ethAddr = await AppRepo.instance.getXmrAddress();
  //   if (ethAddr == null || ethAddr.isEmpty) {
  //     return Future.error("Address Not Found");
  //   }
  //   return BalanceModel(0, 0);
  // }

  Future<BalanceModel> _handleError(e) {
    if (e is DioError) {
      print(e.response);
      return Future.error("Error: ${e.response.statusCode}");
    } else {
      print(e);
      return Future.error("Unkown Error");
    }
  }

  Future<double> getRate(String symbol) async {
    // return 0;
    try {
      final resp = await Dio().get(
          "https://rest.coinapi.io/v1/exchangerate/$symbol/USD?apikey=3FB636EA-2D08-41F6-999D-D4D793E9DCE4");
      return resp.data['rate'];
    } catch (e) {
      return 0;
    }
  }
}
