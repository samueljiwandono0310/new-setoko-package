import 'package:setoko_chat_package/core/models/merchant/profile_picture.dart';

class Merchant {
  String? code;
  String? name;
  String? store;
  String? sellerType;
  ProfilePicture? profilePicture;

  Merchant({this.code, this.name, this.store, this.sellerType, this.profilePicture});

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      code: json['code'] as String?,
      name: json['name'] as String?,
      store: json['store'] as String?,
      sellerType: json['sellerType'] as String?,
      profilePicture: json['profilePicture'] == null
          ? null
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
