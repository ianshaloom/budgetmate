class Budget {
  late final String? id;
  late final String title;
  late final double amount;
  late final DateTime date;

  Budget({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
