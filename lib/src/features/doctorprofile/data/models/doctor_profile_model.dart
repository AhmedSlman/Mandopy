class DoctorProfileModel {
  int? id;
  String? name;
  String? specialization;
  String? phone;
  String? address;
  String? details;
  dynamic image;
  dynamic email;
  dynamic latitude;
  dynamic longitude;
  String? createdAt;
  String? updatedAt;

  DoctorProfileModel(
      {this.id,
      this.name,
      this.specialization,
      this.phone,
      this.address,
      this.details,
      this.image,
      this.email,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialization = json['specialization'];
    phone = json['phone'];
    address = json['address'];
    details = json['details'];
    image = json['image'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['specialization'] = specialization;
    data['phone'] = phone;
    data['address'] = address;
    data['details'] = details;
    data['image'] = image;
    data['email'] = email;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
