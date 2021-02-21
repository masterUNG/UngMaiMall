import 'dart:convert';

class ProductModelString {
  final String product;
  final String amount;
  ProductModelString({
    this.product,
    this.amount,
  });

  ProductModelString copyWith({
    String product,
    String amount,
  }) {
    return ProductModelString(
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

  factory ProductModelString.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductModelString(
      product: map['product'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModelString.fromJson(String source) => ProductModelString.fromMap(json.decode(source));

  @override
  String toString() => 'ProductModelString(product: $product, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProductModelString &&
      o.product == product &&
      o.amount == amount;
  }

  @override
  int get hashCode => product.hashCode ^ amount.hashCode;
}
