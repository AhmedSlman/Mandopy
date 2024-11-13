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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
