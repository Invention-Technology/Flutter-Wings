import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../../immutable/main.wings.dart';
import '../../../immutable/providers/errors/error.model.wings.dart';
import '../../themes/theme.wings.dart';

void errorSnackBar({required ErrorModel? error}) {
  Future.delayed(const Duration(seconds: 0), () {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      borderRadius: BorderRadius.circular(8.0),
      borderColor: error!.borderColor,
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.error,
          color: WingsTheme.dangerDarkColor,
        ),
      ),
      backgroundColor: error.backgroundColor,
      // message: ,
      duration: const Duration(seconds: 3),

      messageText: Text(
        error.message,
        style: WingsTheme.body2,
      ),
    ).show(Wings.context);
  });
}
