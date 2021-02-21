import 'dart:convert';

class BarProductModel {
  final String product;
  final int amount;
  BarProductModel({
    this.product,
    this.amount,
  });

  BarProductModel copyWith({
    String product,
    int amount,
  }) {
    return BarProductModel(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'amount': amount,
    };
  }

  factory BarProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return BarProductModel(
      product: map['product'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BarProductModel.fromJson(String source) => BarProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'BarProductModel(product: $product, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is BarProductModel &&
      o.product == product &&
      o.amount == amount;
  }

  @override
  int get hashCode => product.hashCode ^ amount.hashCode;
}
