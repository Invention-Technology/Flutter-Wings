import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';

void successSnackBar({
  String title = '',
  String message = '',
}) {
  Future.delayed(const Duration(seconds: 0), () {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      borderRadius: BorderRadius.circular(8.0),
      borderColor: const Color(0xff39CC60),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          'assets/icons/success.svg',
          color: const Color(0xff39CC60),
        ),
      ),
      backgroundColor: const Color(0xffE2FFEA),
      // message: ,
      duration: const Duration(seconds: 3),

      messageText: Text(
        message,
        style: WingsTheme.body2,
      ),
    ).show(Get.context!);
  });
}
