class TransactionModel {
  final String? id;
  String description;
  String type;
  double amount;
  DateTime date;
  final String categoryType;
  final String categoryTitle;

  TransactionModel({
    this.id,
    required this.description,
    required this.type,
    required this.amount,
    required this.date,
    required this.categoryType,
    required this.categoryTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'categoryType': categoryType,
      'categoryTitle': categoryTitle,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'].toString(),
      description: map['description'] as String,
      type: map['type'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date']),
      categoryType: map['categoryType'] as String,
      categoryTitle: map['categoryTitle'] as String,
    );
  }
}
