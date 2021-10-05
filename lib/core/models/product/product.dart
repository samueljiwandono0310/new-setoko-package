import 'dart:convert';

import 'package:setoko_chat_package/core/models/product/attribute.dart';
import 'package:setoko_chat_package/core/models/product/media.dart';
import 'package:setoko_chat_package/core/models/product/price.dart';

class Product {
  Product({
    this.code,
    this.name,
    this.description,
    this.price,
    this.medias,
    this.attributes,
  });

  String? code;
  String? name;
  String? description;
  Price? price;
  List<Media>? medias;
  List<Attribute>? attributes;

  Product copyWith({
    String? code,
    String? name,
    String? description,
    Price? price,
    List<Media>? medias,
    List<Attribute>? attributes,
  }) =>
      Product(
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        medias: medias ?? this.medias,
        attributes: attributes ?? this.attributes,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        name: json["name"],
        description: json["description"],
        price: Price.fromJson(json["price"]),
        medias: List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
        attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "description": description,
        "price": price?.toJson(),
        "medias": List<dynamic>.from(medias!.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}
