import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../immutable/utils/screen_util.wings.dart';
import '../../themes/theme.wings.dart';

class LoadingState extends StatelessWidget {
  final double? height;
  final double textSize;
  final double? size;

  const LoadingState({
    Key? key,
    this.size,
    this.height,
    this.textSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: SpinKitPulse(
        color: WingsTheme.primaryColor,
        size: size ?? ScreenUtil.instance.screenWidth / 6,
        // lineWidth: 5,
        duration: const Duration(seconds: 1),
        // type: SpinKitWaveType.end,
      ),
    );
  }
}
