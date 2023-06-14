import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';

import '../../immutable/main.wings.dart';

int _counts = 0;

void loadingDialogHelper() {
  if (_counts > 0) return;

  Future.delayed(const Duration(microseconds: 1), () {
    Wings.isView = false;
    _counts++;

    showDialog(
      context: Wings.context,
      barrierColor: Colors.black12.withOpacity(0.2),
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        return Container(
          color: Colors.black12.withOpacity(0.2),
          child: SpinKitPulse(
            color: WingsTheme.primarySwatch,
            size: 0.075.wsh,
          ),
        );
      },
    );
  });
}

void closeLoadingDialog() {
  Wings.closeWidget();
  _counts--;
}
