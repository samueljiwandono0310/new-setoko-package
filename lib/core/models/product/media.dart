import 'dart:convert';

class Media {
  Media({
    this.kind,
    this.filename,
    this.url,
  });

  String? kind;
  dynamic filename;
  String? url;

  Media copyWith({
    String? kind,
    dynamic filename,
    String? url,
  }) =>
      Media(
        kind: kind ?? this.kind,
        filename: filename ?? this.filename,
        url: url ?? this.url,
      );

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        kind: json["kind"],
        filename: json["filename"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "filename": filename,
        "url": url,
      };
}
