import 'package:get/get.dart';

import '../../../mutable/stores/store.wings.dart';
import '../../base/models/model.wings.dart';
import '../../main.wings.dart';
import '../../providers/errors/error.model.wings.dart';
import '../../providers/errors/exceptions.enum.wings.dart';
import '../../providers/errors/exceptions.wings.dart';
import '../../providers/main.provider.wings.dart';
import '../../providers/remote/request.wings.dart';
import '../../states/state.wings.dart';

class WingsController extends SuperController {
  DataProvider get provider => Wings.provider;

  /// The model that the API data came to
  WingsModel? model;

  Type get type => model.runtimeType;

  /// The state of the widget
  var currentState = WingsState.initial().obs;

  /// call to WingsStore to use it globally
  WingsStore get store => WingsStore.instance;

  /// This variable will contain the response data so it can be called from WingsView
  late dynamic data;

  dynamic get child => this;

  WingsRequest request = WingsRequest(url: '');

  @override
  void onInit() async {
    if (request.url.isNotEmpty) {
      await getData();
    }

    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  Future<void> getData() async {
    if (request.url.isEmpty) return;

    currentState.value = WingsState.loading();

    var response = await provider.get(request: request);

    if (provider.error.message.isNotEmpty) {
      currentState.value = WingsState.error(
        error: provider.error.exception.runtimeType ==
                WingsException.fromEnumeration(
                  ExceptionTypes.empty,
                ).runtimeType
            ? (emptyException ?? provider.error)
            : provider.error,
      );

      return;
    }

    if (model != null) {
      if (response is List) {
        data = model!.fromJsonList(response);
      } else if (response is Map<String, dynamic>) {
        data = model!.fromJson(response);
      } else {
        data = response;
      }
    } else {
      data = response;
    }

    Future.delayed(const Duration(milliseconds: 1000),
        () => currentState.value = WingsState.success());
  }

  Future<dynamic> sendData(
      {List? toList,
      bool showFlushBar = false,
      String? flushBarMessage}) async {
    var response = await provider.insert(request: request);
    dynamic temp;

    if (model != null) {
      if (response is Map<String, dynamic>) {
        temp = model!.fromJson(response);

        if (toList != null) {
          toList.add(temp);
        }
      } else {
        temp = response;
      }
    } else {
      temp = response;
    }

    if (showFlushBar || flushBarMessage != null) {
      currentState.value = WingsState.successFlushBar(
          message: flushBarMessage ?? 'Added Successfully');
    } else {
      currentState.value = WingsState.success();
    }

    return temp;
  }

  ErrorModel? emptyException;

  void customEmptyException({
    required String message,
    String? image,
    String? icon,
  }) {
    emptyException = ErrorModel(
      message: message,
      image: image!,
      icon: icon!,
    );
  }
}
