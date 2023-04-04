class Ticker1 {
  const Ticker1();
  Stream<int> tick({required int time}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => time + x + 1);
  }
}
