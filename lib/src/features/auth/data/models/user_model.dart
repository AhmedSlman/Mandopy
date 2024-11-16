class UserModel {
  final String name;
  final String email;
  final String role;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final dynamic verificationCode;
  String? image;

  UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.verificationCode,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
      verificationCode: json['verification_code'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
      'verification_code': verificationCode,
      'image': image,
    };
  }
}

class RegisterResponse {
  final UserModel user;
  final String message;

  RegisterResponse({required this.user, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      user: UserModel.fromJson(json['user']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'message': message,
    };
  }
}

class LoginResponse {
  final UserModel user;
  final String token;

  LoginResponse({
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json['data']['user']),
      token: json['data']['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'user': user.toJson(),
        'token': token,
      },
    };
  }
}

class VerifyEmailResponse {
  String? message;
  Data? data;

  VerifyEmailResponse({this.message, this.data});

  VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;
  User? user;
  String? token;

  Data({this.message, this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  int? supervisorId;
  String? name;
  String? email;
  String? role;
  String? image;
  String? verificationCode;
  String? verifiedAt;
  int? points;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.supervisorId,
    this.name,
    this.email,
    this.role,
    this.image,
    this.verificationCode,
    this.verifiedAt,
    this.points,
    this.createdAt,
    this.updatedAt,
  });

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
    final Map<String, dynamic> data = {};
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
