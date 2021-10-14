class Logo {
  String? url;

  Logo({this.url});

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': this.url,
      };
}
