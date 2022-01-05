class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;
  static int current_id = 0;
  Transaction({this.title, this.amount}) {
    id = 't$current_id';
    date = DateTime.now();
    current_id++;
  }
}
