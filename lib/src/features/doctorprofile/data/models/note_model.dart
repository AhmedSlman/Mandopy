class NoteModel {
  String? message;
  Note? note;

  NoteModel({this.message, this.note});

  NoteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    return data;
  }
}

class Note {
  int? userId;
  String? doctorId;
  String? pharmacyId;
  String? note;
  String? updatedAt;
  String? createdAt;
  int? id;

  Note(
      {this.userId,
      this.doctorId,
      this.pharmacyId,
      this.note,
      this.updatedAt,
      this.createdAt,
      this.id});

  Note.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    pharmacyId = json['pharmacy_id'];
    note = json['note'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['doctor_id'] = doctorId;
    data['pharmacy_id'] = pharmacyId;
    data['note'] = note;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
