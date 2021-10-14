import 'package:setoko_chat_package/core/models/merchant/profile_picture.dart';

class CTMerchant {
  String? code;
  String? name;
  String? store;
  String? sellerType;
  ProfilePicture? profilePicture;

  CTMerchant({this.code, this.name, this.store, this.sellerType, this.profilePicture});

  factory CTMerchant.fromJson(Map<String, dynamic> json) {
    return CTMerchant(
      code: json['code'] as String?,
      name: json['name'] as String?,
      store: json['store'] as String?,
      sellerType: json['sellerType'] as String?,
      profilePicture: json['profilePicture'] == null
          ? null
          : json['logo'].runtimeType is! Map<String, dynamic>
              ? ProfilePicture.fromJson(json['profilePicture'].toJson())
              : ProfilePicture.fromJson(
                  json['profilePicture'] as Map<String, dynamic>,
                ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'name': this.name,
        'store': this.store,
        'sellerType': this.sellerType,
        'profilePicture': this.profilePicture,
      };
}
