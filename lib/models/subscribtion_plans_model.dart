class SubscriptionPlansModel {
  int? id;
  String? name;
  String? description;
  double? price;
  String? durationInMonths;
  String? currency;

  SubscriptionPlansModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.durationInMonths,
    this.currency,
  });

  factory SubscriptionPlansModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlansModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'],
        durationInMonths: json['durationInMonths'] as String?,
        currency: json['currency'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'durationInMonths': durationInMonths,
    'currency': currency,
  };
}
