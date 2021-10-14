import 'package:setoko_chat_package/core/models/product/logo.dart';

class Brand {
  String? code;
  String? name;
  String? creativeName;
  Logo? logo;

  Brand({this.code, this.name, this.creativeName, this.logo});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      code: json['code'] as String?,
      name: json['name'] as String?,
      creativeName: json['creativeName'] as String?,
      logo: json['logo'] == null ? null : json['logo'].runtimeType is! Map<String, dynamic> ? Logo.fromJson(json['logo'].toJson()) : Logo.fromJson(json['logo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'name': this.name,
        'creativeName': this.creativeName,
        'logo': this.logo,
      };
}
