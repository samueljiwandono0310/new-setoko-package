import 'dart:convert';
import 'package:setoko_chat_package/core/models/product/data.dart';

class Products {
  Products({
    this.data,
  });

  Data? data;

  Products copyWith({
    Data? data,
  }) =>
      Products(
        data: data ?? this.data,
      );

  factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}
