import '../../immutable/base/models/model.wings.dart';
import '../helpers/util.helper.dart';
import 'address.model.dart';
import 'contact.model.dart';
import 'image.model.dart';

class BranchModel extends WingsModel {
  final dynamic id;
  final dynamic name;
  final dynamic domain;
  final List<ContactModel> contacts;
  final AddressModel? address;
  final ImageModel? cover;
  final ImageModel? logo;
  final ImageModel? brand;

  const BranchModel({
    this.id,
    this.name,
    this.domain,
    this.address = const AddressModel(),
    this.contacts = const [],
    this.cover,
    this.brand,
    this.logo,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['_id'],
      name: json['name'],
      domain: json['domain'],
      cover: ImageModel.fromJson(json['cover'] ?? {}),
      logo: ImageModel.fromJson(json['logo'] ?? {}),
      brand: ImageModel.fromJson(json['brand'] ?? {}),
      address: AddressModel.fromJson(json['address'] ?? {}),
      contacts: const ContactModel().fromJsonList(json['contacts'] ?? []),
    );
  }

  @override
  BranchModel fromJson(Map<String, dynamic> json) {
    return BranchModel.fromJson(json);
  }

  @override
  List<BranchModel> fromJsonList(List<dynamic> json) {
    List<BranchModel> companies = [];

    for (var ele in json) {
      companies.add(BranchModel.fromJson(ele));
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
      'cover': cover?.toJson(),
      'brand': brand?.toJson(),
      'logo': logo?.toJson(),
      'address': address?.toJson(),
    };
  }
}
