import 'package:setoko_chat_package/core/models/merchant/merchant.dart';
import 'package:setoko_chat_package/core/models/product/brand.dart';
import 'package:setoko_chat_package/core/models/product/medias.dart';
import 'package:setoko_chat_package/core/models/product/price.dart';
import 'package:setoko_chat_package/core/models/product/primary_category.dart';
import 'package:setoko_chat_package/core/models/product/review.dart';

class CTProductDetailData {
  String? code;
  String? name;
  int? favorites;
  int? stock;
  Price? price;
  String? description;
  double? weight;
  String? youtube;
  List<Medias> medias = [];
  PrimaryCategory? primaryCategory;
  Brand? brand;
  CTMerchant? merchant;
  double? ratingAverage;
  int? reviewCount;
  List<Review> reviews = [];

  CTProductDetailData({
    this.code,
    this.name,
    this.favorites,
    this.stock,
    this.price,
    this.description,
    this.weight,
    this.youtube,
    this.medias = const [],
    this.primaryCategory,
    this.brand,
    this.merchant,
    this.ratingAverage,
    this.reviewCount,
    this.reviews = const [],
  });

  CTProductDetailData.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.name = json['name'];
    this.favorites = json['favorites'];
    this.stock = json['stock'];
    this.price = json['price'] == null
        ? null
        : json['price'].runtimeType is! Map<String, dynamic>
            ? Price.fromJson(json['price'].toJson())
            : Price.fromJson(json['price'] as Map<String, dynamic>);
    this.description = json['description'];
    this.weight = json['weight'];
    this.youtube = json['youtube'];
    if (json["medias"] != null && json["medias"].isNotEmpty) {
      json["medias"].forEach((e) {
        if (e is! Map<String, dynamic>) {
          this.medias.add(Medias.fromJson(e.toJson()));
        } else {
          this.medias.add(Medias.fromJson(e));
        }
      });
    } else {
      this.medias = [];
    }
    this.primaryCategory = json['primaryCategory'] == null
        ? null
        : json['primaryCategory'].runtimeType is! Map<String, dynamic>
            ? PrimaryCategory.fromJson(json['primaryCategory'].toJson())
            : PrimaryCategory.fromJson(json['primaryCategory'] as Map<String, dynamic>);
    this.brand = json['brand'] == null
        ? null
        : json['brand'].runtimeType is! Map<String, dynamic>
            ? Brand.fromJson(json['brand'].toJson())
            : Brand.fromJson(json['brand'] as Map<String, dynamic>);
    this.merchant = json['merchant'] == null
        ? null
        : json['merchant'].runtimeType is! Map<String, dynamic>
            ? CTMerchant.fromJson(json['merchant'].toJson())
            : CTMerchant.fromJson(json['merchant'] as Map<String, dynamic>);
    this.ratingAverage = json['ratingAverage'];
    this.reviewCount = json['reviewCount'];
    if (json["reviews"] != null && json["reviews"].isNotEmpty) {
      json["reviews"].forEach((e) {
        if (e is! Map<String, dynamic>) {
          this.reviews.add(Review.fromJson(e.toJson()));
        } else {
          this.reviews.add(Review.fromJson(e));
        }
      });
    } else {
      this.reviews = [];
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'name': this.name,
        'favorites': this.favorites,
        'stock': this.stock,
        'price': this.price,
        'description': this.description,
        'weight': this.weight,
        'youtube': this.youtube,
        'medias': this.medias,
        'primaryCategory': this.primaryCategory,
        'brand': this.brand,
        'merchant': this.merchant,
        'ratingAverage': this.ratingAverage,
        'reviewCount': this.reviewCount,
        'reviews': this.reviews,
      };
}
