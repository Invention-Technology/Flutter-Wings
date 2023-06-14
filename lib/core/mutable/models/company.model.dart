import '../../immutable/base/models/model.wings.dart';
import '../helpers/util.helper.dart';
import 'contact.model.dart';
import 'image.model.dart';

class CompanyModel extends WingsModel {
  final dynamic id;
  final dynamic name;
  final dynamic domain;
  final List<ContactModel> contacts;
  final ImageModel? logo;
  final ImageModel? brand;
  final ImageModel? cover;

  CompanyModel({
    this.id,
    this.name,
    this.domain,
    this.contacts = const [],
    this.logo,
    this.brand,
    this.cover,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['_id'],
      name: json['name'],
      domain: json['domain'],
      brand: ImageModel.fromJson(json['brand'] ?? {}),
      logo: ImageModel.fromJson(json['logo'] ?? {}),
      cover: ImageModel.fromJson(json['cover'] ?? {}),
      contacts: const ContactModel().fromJsonList(json['contacts'] ?? []),
    );
  }

  @override
  CompanyModel fromJson(Map<String, dynamic> json) {
    return CompanyModel.fromJson(json);
  }

  @override
  List<CompanyModel> fromJsonList(List<dynamic> json) {
    List<CompanyModel> companies = [];

    for (var ele in json) {
      companies.add(CompanyModel.fromJson(ele));
    }

    return companies;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'domain': domain,
      'contacts': contacts.toJson(),
      'brand': brand?.toJson(),
      'logo': logo?.toJson(),
      'cover': cover?.toJson(),
    };
  }
}
