class Reviewer {
  String? name;
  Reviewer({
    this.name,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
      };
}
