class Transaction {
  String id;
  String title;
  double amount = 0;
  DateTime date;
  static int current_id = 0;
  Transaction({this.title, this.amount, this.date}) {
    id = 't$current_id';
    date = date;
    current_id++;
  }
}
