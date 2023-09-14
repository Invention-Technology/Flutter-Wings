import 'package:wings/core/immutable/base/models/model.wings.dart';
import 'package:wings/core/mutable/models/address.model.dart';
import 'package:wings/core/mutable/models/image.model.dart';

class UserModel extends WingsModel {
  dynamic id;
  dynamic fullName;
  dynamic phone;
  dynamic token;
  dynamic fcmToken;
  dynamic message;
  dynamic statusRequest;
  ImageModel avatar;
  AddressModel address;

  UserModel({
    this.id = '',
    this.phone = '',
    this.fullName = '',
    this.token = '',
    this.fcmToken = '',
    this.message = '',
    this.statusRequest,
    this.address = const AddressModel(),
    this.avatar = const ImageModel(),
  });

  bool get verifiedProvider => statusRequest == 1;

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json['fullName'] ?? '',
        phone: json['phone'] ?? '',
        id: json['_id'] ?? '',
        token: json['token'] ?? '',
        fcmToken: json['fcmToken'] ?? '',
        message: json['message'] ?? '',
        statusRequest: json['statusRequest'],
        address: AddressModel.fromJson(json['address'] ?? {}),
        avatar: ImageModel.fromJson(json['avatar'] ?? {}));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      '_id': id,
      'token': token,
      'fcmToken': fcmToken,
      'message': message,
      'statusRequest': statusRequest,
      'address': address.toJson(),
      'avatar': avatar.toJson(),
    };
  }
}
