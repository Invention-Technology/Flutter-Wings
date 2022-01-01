import 'package:flutter/material.dart';

import '../../../immutable/providers/errors/error.model.wings.dart';
import '../../helpers/snack_bar/error_snack_bar.helper.wings.dart'
    as error_snack_bar;
import '../../helpers/snack_bar/success_snack_bar.helper.wings.dart'
    as success_snack_bar;
import 'error_state.widget.wings.dart';
import 'loading_state.widget.wings.dart';

class WingsAppState {
  static Widget defaultWidgetState() {
    return loading();
  }

  static Widget errorState({onRefresh, error}) {
    return WingsErrorState(
      onRefresh: onRefresh,
      error: error,
    );
  }

  static Widget loading() {
    return const LoadingState();
  }

  static void successSnackBar({String message = '', String title = ''}) {
    success_snack_bar.successSnackBar(message: message, title: title);
  }

  static void errorSnackBar({ErrorModel? error}) {
    error_snack_bar.errorSnackBar(error: error);
  }
}
