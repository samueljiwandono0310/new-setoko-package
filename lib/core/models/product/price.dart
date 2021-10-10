class Price {
  double? normal;
  double? promo;
  double? setoko;

  Price({this.normal, this.promo, this.setoko});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      normal: (json['normal'] as num?)?.toDouble(),
      promo: (json['promo'] as num?)?.toDouble(),
      setoko: (json['setoko'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'normal': this.normal,
        'promo': this.promo,
        'setoko': this.setoko,
      };
}
