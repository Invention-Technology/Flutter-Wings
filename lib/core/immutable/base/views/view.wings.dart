import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mutable/widgets/default_appbar.widget.wings.dart';
import '../../../mutable/widgets/states/app_state.static.wings.dart';
import '../../states/state.wings.dart';
import '../../utils/screen_util.wings.dart';
import '../controllers/controller.wings.dart';
import '../models/model.wings.dart';

class WingsView<T> extends StatelessWidget {
  late final WingsController _controller;

  WingsView({Key? key, required WingsController controller}) : super(key: key) {
    _controller = Get.put(controller, tag: '${controller.runtimeType}');
  }

  T get controller => _controller.child;

  WingsModel get model => _controller.model!;

  WingsState get currentState => _controller.currentState.value;

  ScreenUtil get screenUtil => ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackgroundColor,
      appBar: pageAppBar(context),
      body: GetX(
          init: _controller,
          builder: (_) {
            if (currentState.isError) {
              return WingsAppState.errorState(
                onRefresh: _controller.getData,
                error: currentState.errorData,
              );
            }

            if (currentState.isSuccessFlushBar) {
              WingsAppState.successSnackBar(
                message: currentState.flushSuccessMessage,
                title: currentState.flushSuccessTitle,
              );
              Future.delayed(const Duration(milliseconds: 10), () {
                _controller.currentState.value = WingsState.success();
              });
            }

            if (currentState.isErrorFlushBar) {
              WingsAppState.errorSnackBar(error: currentState.flushErrorData);
              Future.delayed(const Duration(milliseconds: 10), () {
                _controller.currentState.value = WingsState.success();
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
          }),
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget successState(BuildContext context) {
    return Container();
  }

  Widget initialState(BuildContext context) {
    return Container();
  }

  PreferredSizeWidget? pageAppBar(BuildContext context) {
    return wingsDefaultAppbar(context);
  }

  Widget bottomNavigationBar() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }

  Widget floatingActionButton() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}
