class TransactionsHistoryDataModel {
  final String method;
  final String orderNumber;
  final String date;
  final String numberOfTransactions;

  TransactionsHistoryDataModel({
    required this.method,
    required this.orderNumber,
    required this.date,
    required this.numberOfTransactions,
  });
}