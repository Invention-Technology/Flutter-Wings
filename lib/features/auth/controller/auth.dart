import 'dart:convert';
import 'dart:developer';

import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/local/local.provider.wings.dart';
import 'package:wings/core/mutable/notifications/notification.service.dart';

import '../../../core/mutable/notifications/topics.enum.dart';
import '../model/user.model.dart';

class Auth extends WingsController {
  factory Auth() {
    _instance ??= Auth._();

    return _instance!;
  }

  final String _key = 'user';

  get avatar => user.avatar.path;

  bool get hasImage => avatar != null && avatar.isNotEmpty;

  Auth._();

  @override
  void onInit() async {
    try {
      var read = await WingsLocalProvider().read(key: _key);

      if (read != null) {
        user = UserModel().fromJson(jsonDecode(read));
      }
    } catch (ex) {
      log("$ex", name: "Wings Local");
    }

    model = UserModel();
  }

  static Auth? _instance;

  UserModel user = UserModel();

  String get phone => user.phone.toString();
  String tempPhone = '';
  dynamic tempOTP;

  String get fullName => user.fullName;

  bool get loggedIn => token.isNotEmpty;

  String get token => user.token;

  bool get newUser => user.statusRequest == null;

  bool get verifiedProvider => user.verifiedProvider;

  void setPhone(String phone, {dynamic otp}) {
    tempPhone = phone;
    tempOTP = otp ?? '';
  }

  Future<void> login(dynamic data) async {
    user = UserModel().fromJson(data);

    _writeToCache();

    await PushNotificationService().unsubscribe(topics: Topics.guests);
    await PushNotificationService().subscribe();

    if (newUser) {
      // TODO: Complete User Registration
      return;
    }

    if (!verifiedProvider) {
      // TODO: Show Pending View
    }
  }

  void logout() async {
    user = UserModel();

    await PushNotificationService().unsubscribe(loggedIn: true);
    await PushNotificationService().subscribe(topics: Topics.guests);

    await WingsLocalProvider().delete(key: _key);
  }

  updateNameNoRequest(String name) {
    user.fullName = name;

    _writeToCache();
  }

  Future<void> updatePhone({required String phone}) async {
    user.phone = phone;

    _writeToCache();
  }

  Future<void> updateStatusRequest(statusRequest) async {
    user.statusRequest = statusRequest;

    _writeToCache();
  }

  bool currentUser(userId) {
    return user.id == userId;
  }

  void updateUser(UserModel user) {
    this.user = user;

    _writeToCache();
  }

  void updateAvatar(UserModel user) {
    this.user.avatar = user.avatar;

    _writeToCache();
  }

  _writeToCache() {
    WingsLocalProvider().write(key: _key, value: user.toJson());
  }

  void updateToken(String token) {
    user.token = token;

    _writeToCache();
  }
}
