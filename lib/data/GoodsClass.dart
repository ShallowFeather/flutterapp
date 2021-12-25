class LastGoods {
  final int? id;
  final String name;
  final String type;
  final int cost;
  final DateTime date;
  final String other;
  LastGoods({
    this.id,
    required this.name,
    required this.type,
    required this.cost,
    required this.date,
    required this.other,
  });

  static LastGoods formMap(Map<String, dynamic> json) => LastGoods(
      id: json["id"] as int?,
      name: json["name"] as String,
      type: json["type"] as String,
      cost: json["cost"] as int,
      date: DateTime.parse(json["date"] as String),
      other: json["other"] as String);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'cost': cost,
      'date': date,
      'other': other,
    };
  }

  LastGoods copy({
    int? id,
    String? name,
    String? type,
    int? cost,
    String? date,
    String? other,
  }) =>
      LastGoods(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        cost: cost ?? this.cost,
        date: date ?? this.date,
        other: other ?? this.other,
      );
}