import 'dart:convert';

import 'package:setoko_chat_package/core/models/product/product.dart';

class Data {
  Data({
    this.products,
  });

  List<Product>? products;

  Data copyWith({
    List<Product>? products,
  }) =>
      Data(
        products: products ?? this.products,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
