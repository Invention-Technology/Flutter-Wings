import 'package:wings/core/immutable/base/middlewares/middleware.wings.dart';
import 'package:wings/core/immutable/binding/reactive.binding.dart';

import '../../../mutable/stores/store.wings.dart';
import '../../base/models/model.wings.dart';
import '../../main.wings.dart';
import '../../providers/errors/error.model.wings.dart';
import '../../providers/errors/exceptions.enum.wings.dart';
import '../../providers/errors/exceptions.wings.dart';
import '../../providers/main.provider.wings.dart';
import '../../providers/remote/request.wings.dart';
import '../../states/state.wings.dart';

class WingsController {
  WingsController() {
    fillMiddlewares();

    state.stream.listen((event) {
      onStatusChanged();
    });

    onInit();
  }

  static WingsController? _instance;

  static WingsController get instance {
    _instance ??= WingsController();

    return _instance!;
  }

  DataProvider get provider => Wings.provider;

  Map<String, dynamic> arguments = {};

  List<WingsMiddleware> middlewares = [];

  /// The model that the API data came to
  WingsModel? model;

  Type get type => model.runtimeType;

  /// The state of the widget
  var state = WingsState.initial().wis;

  /// call to WingsStore to use it globally
  WingsStore get store => WingsStore.instance;

  /// This variable will contain the response data so it can be called from WingsView
  late dynamic data;

  dynamic get child => this;

  WingsRequest request = WingsRequest(url: '');

  void onInit() async {
    if (request.url.isNotEmpty) {
      await getData();
    }
  }

  void onReady() {
    if (Wings.arguments.isNotEmpty) {
      arguments = Wings.arguments;
      Wings.arguments = {};
    }
  }

  Future<void> getData() async {
    if (request.url.isEmpty) return;

    state.data = WingsState.loading();

    var response = await provider.get(request: request);

    if (provider.error.message.isNotEmpty) {
      state.data = WingsState.error(
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

    Future.delayed(const Duration(milliseconds: 1000), () {
      return state.data = WingsState.success();
    });
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
      state.data = WingsState.successFlushBar(
          message: flushBarMessage ?? 'Added Successfully');
    } else {
      state.data = WingsState.success();
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

  void fillMiddlewares() {
    middlewares = [];
  }

  void onStatusChanged() {}
}
