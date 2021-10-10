class Medias {
  String? kind;
  String? filename;
  String? url;

  Medias({this.kind, this.filename, this.url});

  factory Medias.fromJson(Map<String, dynamic> json) {
    return Medias(
      kind: json['kind'] as String?,
      filename: json['filename'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'kind': this.kind,
        'filename': this.filename,
        'url': this.url,
      };
}
