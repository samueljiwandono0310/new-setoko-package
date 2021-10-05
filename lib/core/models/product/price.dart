import 'dart:convert';

class Price {
  Price({
    this.normal,
    this.promo,
    this.subscription,
  });

  int? normal;
  int? promo;
  int? subscription;

  Price copyWith({
    int? normal,
    int? promo,
    int? subscription,
  }) =>
      Price(
        normal: normal ?? this.normal,
        promo: promo ?? this.promo,
        subscription: subscription ?? this.subscription,
      );

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        normal: json["normal"],
        promo: json["promo"],
        subscription: json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "normal": normal,
        "promo": promo,
        "subscription": subscription,
      };
}
