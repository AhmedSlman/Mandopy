class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? supervisorId;
  String? name;
  String? email;
  String? role;
  Null image;
  Null verificationCode;
  String? verifiedAt;
  int? points;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.supervisorId,
      this.name,
      this.email,
      this.role,
      this.image,
      this.verificationCode,
      this.verifiedAt,
      this.points,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supervisorId = json['supervisor_id'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['supervisor_id'] = supervisorId;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['image'] = image;
    data['verification_code'] = verificationCode;
    data['verified_at'] = verifiedAt;
    data['points'] = points;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
