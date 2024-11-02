class Representative {
  int? id;
  String? name;
  String? email;
  String? role;
  String? image;
  Null? verificationCode;
  String? verifiedAt;
  int? points;
  String? createdAt;
  String? updatedAt;

  Representative(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.image,
      this.verificationCode,
      this.verifiedAt,
      this.points,
      this.createdAt,
      this.updatedAt});

  Representative.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
    verificationCode = json['verification_code'];
    verifiedAt = json['verified_at'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['image'] = this.image;
    data['verification_code'] = this.verificationCode;
    data['verified_at'] = this.verifiedAt;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
