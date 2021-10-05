import 'dart:convert';

class Attribute {
  Attribute({
    this.kind,
  });

  String? kind;

  Attribute copyWith({
    String? kind,
  }) =>
      Attribute(
        kind: kind ?? this.kind,
      );

  factory Attribute.fromRawJson(String str) => Attribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        kind: json["kind"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
      };
}