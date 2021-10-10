class ReviewMedia {
  String? kind;
  String? url;
  ReviewMedia({
    this.kind,
    this.url,
  });

  factory ReviewMedia.fromJson(Map<String, dynamic> json) {
    return ReviewMedia(
      kind: json['kind'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'kind': this.kind,
        'url': this.url,
      };
}
