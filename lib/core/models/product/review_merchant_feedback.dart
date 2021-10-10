class ReviewMerchantFeedback {
  String? comment;
  DateTime? createdAt;
  ReviewMerchantFeedback({
    this.comment,
    this.createdAt,
  });

  factory ReviewMerchantFeedback.fromJson(Map<String, dynamic> json) {
    return ReviewMerchantFeedback(
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comment': this.comment,
        'createdAt': this.createdAt?.toIso8601String(),
      };
}
