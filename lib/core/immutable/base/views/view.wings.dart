import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../mutable/helpers/loading.dialog.helper.dart';
import '../../../mutable/helpers/util.helper.dart';
import '../../../mutable/themes/theme.wings.dart';
import '../../../mutable/widgets/default_appbar.widget.wings.dart';
import '../../../mutable/widgets/default_drawer.widget.wings.dart';
import '../../../mutable/widgets/states/app_state.static.wings.dart';
import '../../binding/main.bidings.dart';
import '../../main.wings.dart';
import '../../states/state.wings.dart';
import '../../utils/screen_util.wings.dart';
import '../controllers/controller.wings.dart';
import '../middlewares/middleware.wings.dart';
import '../models/model.wings.dart';

// ignore: must_be_immutable
class WingsView<T> extends StatelessWidget {
  late final WingsController _controller;

  WingsView({
    Key? key,
    required WingsController controller,
    String? tag,
    bool permanent = false,
  }) : super(key: key) {
    _controllerTag = tag ?? controller.runtimeType.toString();

    _controller = Wings.add(controller, tag: tag, permanent: permanent);

    key ??= GlobalKey();
  }

  T get controller => _controller.child;

  String? _controllerTag;

  List<WingsMiddleware> get middlewares => _controller.middlewares;

  WingsModel get model => _controller.model!;

  WingsState get state => _controller.state.value;

  ScreenUtil get screenUtil => ScreenUtil.instance;

  String? get appbarTitle => null;

  List<Widget>? get actions => null;

  bool get hideAppbar => false;

  @override
  Widget build(BuildContext context) {
    _controller.onReady();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: WingsTheme.scaffoldBackgroundColor,
        appBar: pageAppBar(context),
        drawer: drawer(),
        drawerEnableOpenDragGesture: false,
        body: Wx(
            controller: _controller.state,
            builder: (_) {
              if (state.isError) {
                return WingsAppState.errorState(
                  onRefresh: _controller.getData,
                  error: state.errorData,
                );
              }

              if (state.isEmpty) {
                return WingsAppState.emptyState(
                  error: state.errorData,
                );
              }

              if (state.isSuccessFlushBar) {
                WingsAppState.successSnackBar(
                  message: state.flushSuccessMessage,
                );
                Future.delayed(const Duration(milliseconds: 10), () {
                  _controller.state.value = WingsState.success();
                });
              }

              if (state.isErrorFlushBar) {
                WingsAppState.errorSnackBar(error: state.flushErrorData);
                Future.delayed(const Duration(milliseconds: 10), () {
                  _controller.state.value = WingsState.success();
                });
              }

              if (state.isLoadingMore) {
                loadingDialogHelper();
              }

              if (state.isSuccess ||
                  state.isSuccessFlushBar ||
                  state.isLoadingMore ||
                  state.isErrorFlushBar) {
                return successState(context);
              }

              if (state.isInitial) {
                return initialState(context);
              }

              return WingsAppState.defaultWidgetState();
            }),
        floatingActionButton: Wx(
          controller: _controller.state,
          builder: (_) {
            if (state.isSuccess ||
                state.isSuccessFlushBar ||
                state.isLoadingMore ||
                state.isErrorFlushBar) {
              _noFloatingActionButton = false;
              return floatingActionButton();
            }

            _noFloatingActionButton = true;
            return const SizedBox();
          },
        ),
        floatingActionButtonLocation:
            _noFloatingActionButton ? null : floatingActionButtonLocation,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }

  bool get resizeToAvoidBottomInset => true;

  bool _noFloatingActionButton = true;

  void onBackButtonClicked() {
    Wings.pop();
  }

  FloatingActionButtonLocation get floatingActionButtonLocation {
    return FloatingActionButtonLocation.endFloat;
  }

  Widget successState(BuildContext context) {
    return const SizedBox();
  }

  Widget initialState(BuildContext context) {
    return const SizedBox();
  }

  PreferredSizeWidget? pageAppBar(BuildContext context) {
    return wingsDefaultAppbar(context, title: appbarTitle, actions: actions);
  }

  Widget? drawer() {
    return const WingsDefaultDrawerWidget();
  }

  Widget bottomNavigationBar() {
    return const SizedBox();
  }

  Widget floatingActionButton() {
    return const SizedBox();
  }

  Widget lastItemInPaginationList() {
    if (_controller.lastPage) {
      return const SizedBox();
    } else {
      _controller.nextPage();

      return SpinKitPulse(
        color: WingsTheme.primarySwatch,
        size: 0.05.wsh,
      );
    }
  }

  Future<bool> onWillPop() {
    Wings.remove(tag: _controllerTag);

    return Future.value(true);
  }
}
