class PharmacyProfileModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? details;
  dynamic image;
  dynamic latitude;
  dynamic longitude;
  String? createdAt;
  String? updatedAt;

  PharmacyProfileModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.details,
      this.image,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  PharmacyProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    details = json['details'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['details'] = details;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
