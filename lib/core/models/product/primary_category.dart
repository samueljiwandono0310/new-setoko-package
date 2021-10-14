class PrimaryCategory {
  int? id;
  String? code;
  String? name;

  PrimaryCategory({this.id, this.code, this.name});

  factory PrimaryCategory.fromJson(Map<String, dynamic> json) {
    return PrimaryCategory(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'code': this.code,
        'name': this.name,
      };
}
