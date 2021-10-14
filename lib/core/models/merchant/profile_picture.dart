class ProfilePicture {
  String? url;
  String? kind;
  String? filename;
  ProfilePicture({
    this.url,
    this.kind,
    this.filename,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      url: json['url'] as String?,
      kind: json['kind'] as String?,
      filename: json['filename'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': this.url,
        'kind': this.kind,
        'filename': this.filename,
      };
}
