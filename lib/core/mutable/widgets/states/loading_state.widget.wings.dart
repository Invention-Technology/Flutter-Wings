import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../immutable/utils/screen_util.wings.dart';
import '../../themes/theme.wings.dart';

class LoadingState extends StatelessWidget {
  final double? height;
  final double textSize;

  const LoadingState({
    Key? key,
    double size = 50,
    this.height,
    this.textSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? ScreenUtil.instance.screenHeightNoPaddingNoAppbar,
      alignment: Alignment.center,
      child: SpinKitRing(
        color: WingsTheme.primaryColor,
        size: ScreenUtil.instance.screenWidth / 5,
        duration: const Duration(seconds: 1),
        // type: SpinKitWaveType.end,
      ),
    );
  }
}
