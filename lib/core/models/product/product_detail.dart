import 'package:setoko_chat_package/core/models/merchant/merchant.dart';
import 'package:setoko_chat_package/core/models/product/brand.dart';
import 'package:setoko_chat_package/core/models/product/medias.dart';
import 'package:setoko_chat_package/core/models/product/price.dart';
import 'package:setoko_chat_package/core/models/product/primary_category.dart';
import 'package:setoko_chat_package/core/models/product/review.dart';

class ProductDetailData {
  String? code;
  String? name;
  int? favorites;
  int? stock;
  Price? price;
  String? description;
  double? weight;
  String? youtube;
  List<Medias>? medias;
  PrimaryCategory? primaryCategory;
  Brand? brand;
  Merchant? merchant;
  double? ratingAverage;
  int? reviewCount;
  List<Review>? reviews;

  ProductDetailData({
    this.code,
    this.name,
    this.favorites,
    this.stock,
    this.price,
    this.description,
    this.weight,
    this.youtube,
    this.medias,
    this.primaryCategory,
    this.brand,
    this.merchant,
    this.ratingAverage,
    this.reviewCount,
    this.reviews,
  });

  factory ProductDetailData.fromJson(Map<String, dynamic> json) {
    return ProductDetailData(
      code: json['code'] as String?,
      name: json['name'] as String?,
      favorites: json['favorites'] as int?,
      stock: json['stock'] as int?,
      price: json['price'] == null ? null : Price.fromJson(json['price'] as Map<String, dynamic>),
      description: json['description'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      youtube: json['youtube'] as String?,
      medias: (json['medias'] as List<dynamic>?)?.map((e) => Medias.fromJson(e as Map<String, dynamic>)).toList(),
      primaryCategory: json['primaryCategory'] == null ? null : PrimaryCategory.fromJson(json['primaryCategory'] as Map<String, dynamic>),
      brand: json['brand'] == null ? null : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      merchant: json['merchant'] == null ? null : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      ratingAverage: (json['ratingAverage'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList(),
    );
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
