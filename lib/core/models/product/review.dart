import 'package:setoko_chat_package/core/models/product/review_media.dart';
import 'package:setoko_chat_package/core/models/product/review_merchant_feedback.dart';
import 'package:setoko_chat_package/core/models/product/reviewer.dart';

class Review {
  Reviewer? reviewer;
  int? rating;
  String? comment;
  List<ReviewMedia> medias = [];
  DateTime? createdAt;
  ReviewMerchantFeedback? merchantFeedback;
  List<String> tags = [];
  Review({
    this.reviewer,
    this.rating,
    this.comment,
    this.medias = const [],
    this.createdAt,
    this.tags = const [],
  });

  Review.fromJson(Map<String, dynamic> json) {
    this.reviewer = json['reviewer'] == null ? null : json['reviewer'].runtimeType is! Map<String, dynamic> ? Reviewer.fromJson(json['reviewer'].toJson()) : Reviewer.fromJson(json['reviewer'] as Map<String, dynamic>);
    this.rating = json['rating'];
    this.comment = json['comment'];
    if (json["medias"] != null && json["medias"].isNotEmpty) {
      json["medias"].forEach((e) {
        if (e is! Map<String, dynamic>) {
          this.medias.add(ReviewMedia.fromJson(e.toJson()));
        } else {
          this.medias.add(ReviewMedia.fromJson(e));
        }
      });
    } else {
      this.medias = [];
    }
    this.createdAt = json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String);
    if (json["tags"] != null && json["tags"].isNotEmpty) {
      json["tags"].forEach((e) {
        this.tags.add(e);
      });
    } else {
      this.tags = [];
    }
    this.merchantFeedback = json['merchantFeedback'] == null ? null : json['merchantFeedback'].runtimeType is! Map<String, dynamic> ? ReviewMerchantFeedback.fromJson(json['merchantFeedback'].toJson()) : ReviewMerchantFeedback.fromJson(json['merchantFeedback'] as Map<String, dynamic>);
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
