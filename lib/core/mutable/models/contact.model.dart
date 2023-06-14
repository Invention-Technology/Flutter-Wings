import '../../immutable/base/models/model.wings.dart';

class ContactModel extends WingsModel {
  final dynamic id;
  final dynamic contact;
  final dynamic type;

  const ContactModel({
    this.id = '',
    this.contact = '',
    this.type = '',
  });

  @override
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'] ?? '',
      contact: json['contact'] ?? '',
      type: json['type'] ?? '',
    );
  }

  @override
  List<ContactModel> fromJsonList(List<dynamic> json) {
    List<ContactModel> images = [];

    for (var ele in json) {
      images.add(ContactModel.fromJson(ele));
    }

    return images;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'contact': contact,
      'type': type,
    };
  }
}
