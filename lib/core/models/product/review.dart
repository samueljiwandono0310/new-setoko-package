import 'package:setoko_chat_package/core/models/product/review_media.dart';
import 'package:setoko_chat_package/core/models/product/review_merchant_feedback.dart';
import 'package:setoko_chat_package/core/models/product/reviewer.dart';

class Review {
  Reviewer? reviewer;
  int? rating;
  String? comment;
  List<ReviewMedia>? medias;
  DateTime? createdAt;
  ReviewMerchantFeedback? merchantFeedback;
  List<String>? tags;
  Review({
    this.reviewer,
    this.rating,
    this.comment,
    this.medias,
    this.createdAt,
    this.tags,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewer: json['reviewer'] == null ? null : Reviewer.fromJson(json['reviewer'] as Map<String, dynamic>),
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      medias: (json['medias'] as List<dynamic>?)?.map((e) => ReviewMedia.fromJson(e as Map<String, dynamic>)).toList(),
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..merchantFeedback = json['merchantFeedback'] == null
        ? null
        : ReviewMerchantFeedback.fromJson(
            json['merchantFeedback'] as Map<String, dynamic>,
          );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'reviewer': this.reviewer,
        'rating': this.rating,
        'comment': this.comment,
        'medias': this.medias,
        'createdAt': this.createdAt?.toIso8601String(),
        'merchantFeedback': this.merchantFeedback,
        'tags': this.tags,
      };
}
