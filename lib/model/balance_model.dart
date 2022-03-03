class BalanceModel{
  final double cript;
  final double rate;

  BalanceModel(this.cript, this.rate);

  double get balance => cript * rate;
}