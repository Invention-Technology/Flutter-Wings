import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wings/core/immutable/base/middlewares/middleware.wings.dart';
import 'package:wings/core/immutable/binding/main.bidings.dart';

import '../../../mutable/widgets/default_appbar.widget.wings.dart';
import '../../../mutable/widgets/states/app_state.static.wings.dart';
import '../../main.wings.dart';
import '../../states/state.wings.dart';
import '../../utils/screen_util.wings.dart';
import '../controllers/controller.wings.dart';
import '../models/model.wings.dart';

// ignore: must_be_immutable
class WingsView<T> extends StatelessWidget {
  late final WingsController _controller;

  WingsView({Key? key, required WingsController controller, String? tag})
      : super(key: key) {
    _controllerTag = tag ?? controller.runtimeType.toString();

    _controller = Wings.add(controller, tag: tag);
  }

  T get controller => _controller.child;

  String? _controllerTag;

  List<WingsMiddleware> get middlewares => _controller.middlewares;

  WingsModel get model => _controller.model!;

  WingsState get state => _controller.state.data;

  ScreenUtil get screenUtil => ScreenUtil.instance;

  @override
  Widget build(BuildContext context) {
    _controller.onReady();
    return WillPopScope(
      onWillPop: () {
        log('onWillPop called', name: 'Remove before publishing');
        Wings.remove(tag: _controllerTag);

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ThemeData().scaffoldBackgroundColor,
        appBar: pageAppBar(context),
        body: Wx(
            controller: _controller.state,
            builder: (_) {
              if (state.isError) {
                return WingsAppState.errorState(
                  onRefresh: _controller.getData,
                  error: state.errorData,
                );
              }

              if (state.isSuccessFlushBar) {
                WingsAppState.successSnackBar(
                  message: state.flushSuccessMessage,
                  title: state.flushSuccessTitle,
                );
                Future.delayed(const Duration(milliseconds: 10), () {
                  _controller.state.data = WingsState.success();
                });
              }

              if (state.isErrorFlushBar) {
                WingsAppState.errorSnackBar(error: state.flushErrorData);
                Future.delayed(const Duration(milliseconds: 10), () {
                  _controller.state.data = WingsState.success();
                });
              }
              if (state.isSuccess ||
                  state.isLoadingMore ||
                  state.isSuccessFlushBar ||
                  state.isErrorFlushBar) {
                return successState(context);
              }

              if (state.isInitial) {
                return initialState(context);
              }

              return WingsAppState.defaultWidgetState();
            }),
        bottomNavigationBar: bottomNavigationBar(),
        floatingActionButton: floatingActionButton(),
      ),
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
