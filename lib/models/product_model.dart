import 'dart:convert';

class ProductModel {
  final int product;
  final int amount;
  ProductModel({
    this.product,
    this.amount,
  });

  ProductModel copyWith({
    int product,
    int amount,
  }) {
    return ProductModel(
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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductModel(
      product: map['product'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductModel(product: $product, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProductModel &&
      o.product == product &&
      o.amount == amount;
  }

  @override
  int get hashCode => product.hashCode ^ amount.hashCode;
}
