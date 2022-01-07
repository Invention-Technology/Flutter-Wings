import 'package:get/get.dart';

import '../../../mutable/stores/store.wings.dart';
import '../../main.wings.dart';
import '../../providers/main.provider.wings.dart';
import '../../providers/remote/request.wings.dart';
import '../../states/state.wings.dart';
import '../models/model.wings.dart';

class WingsWatcher extends SuperController {
  DataProvider get provider => Wings.provider;

  /// The url to call REST API if it is needed
  /// leave it empty if this widget doesn't call an API
  WingsRequest? request;

  /// The model that the API data came to
  WingsModel? model;

  /// The state of the widget
  var currentState = WingsState.initial().obs;

  /// call to WingsStore to use it globally
  WingsStore get store => WingsStore.instance;

  /// The controller that this watcher called from to call the controller-specific data
  late dynamic controller;

  /// This variable will contain the response data so it can be called from WingsWidget
  dynamic data;

  WingsWatcher({this.controller});

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

  void fetchData() async {
    if (request == null) return;

    currentState.value = WingsState.loading();

    var response = await provider.get(request: request!);

    if (provider.error.message.isNotEmpty) {
      currentState.value = WingsState.error(error: provider.error);

      return;
    }

    data = model!.fromJsonList(response);

    currentState.value = WingsState.success();
  }

  void sendData() async {
    await provider.insert(request: request!);
  }
}
