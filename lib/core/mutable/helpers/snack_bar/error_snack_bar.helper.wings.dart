import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../immutable/providers/errors/error.model.wings.dart';
import '../../themes/theme.wings.dart';

void errorSnackBar({required ErrorModel? error}) {
  Future.delayed(const Duration(seconds: 0), () {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      borderRadius: BorderRadius.circular(8.0),
      borderColor: error!.borderColor,
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          error.icon,
          color: error.borderColor,
        ),
      ),
      backgroundColor: error.backgroundColor,
      // message: ,
      duration: const Duration(seconds: 3),

      messageText: Text(
        error.message,
        style: WingsTheme.body2,
      ),
    ).show(Get.context!);
  });
}
