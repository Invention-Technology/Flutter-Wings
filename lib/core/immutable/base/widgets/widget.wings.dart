import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mutable/widgets/states/app_state.static.wings.dart';
import '../../states/state.wings.dart';
import '../watchers/watcher.wings.dart';

class WingsWidget extends StatelessWidget {
  late final WingsWatcher watcher;

  WingsWidget({Key? key, required dynamic watcher}) : super(key: key) {
    this.watcher = Get.put(watcher, tag: watcher.toString());
  }

  WingsState get currentState => watcher.currentState.value;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: watcher,
        builder: (_) {
          if (currentState.isError) {
            return WingsAppState.errorState(
              onRefresh: watcher.fetchData,
              error: currentState.errorData,
            );
          }

          if (currentState.isSuccessFlushBar) {
            WingsAppState.successSnackBar(
              message: currentState.flushSuccessMessage,
              title: currentState.flushSuccessTitle,
            );
            Future.delayed(const Duration(milliseconds: 10), () {
              watcher.currentState.value = WingsState.success();
            });
          }

          if (currentState.isErrorFlushBar) {
            WingsAppState.errorSnackBar(error: currentState.flushErrorData);
            Future.delayed(const Duration(milliseconds: 10), () {
              watcher.currentState.value = WingsState.success();
            });
          }
          if (currentState.isSuccess ||
              currentState.isLoadingMore ||
              currentState.isSuccessFlushBar ||
              currentState.isErrorFlushBar) {
            return successState(context);
          }

          if (currentState.isInitial) {
            return initialState(context);
          }

          return WingsAppState.defaultWidgetState();
        });
  }

  Widget successState(BuildContext context) {
    return Container();
  }

  Widget initialState(BuildContext context) {
    return Container();
  }
}
