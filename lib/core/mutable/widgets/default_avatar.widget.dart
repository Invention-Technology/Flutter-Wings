import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/util.helper.dart';
import '../themes/theme.wings.dart';
import 'svg.widget.dart';

class DefaultAvatarWidget extends StatelessWidget {
  /// size less than one since it will be converted using .wsh
  final double size;

  const DefaultAvatarWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
          )
        ],
      ),
      padding: EdgeInsets.all(0.05.sw),
      child: SvgWidget(
        "account.svg",
        height: size.wsh,
        width: size.wsh,
        color: WingsTheme.primaryColor,
      ),
    );
  }
}
