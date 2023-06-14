import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../immutable/providers/errors/error.model.wings.dart';
import '../../themes/theme.wings.dart';

class WingsErrorState extends StatelessWidget {
  const WingsErrorState({
    Key? key,
    this.onRefresh,
    this.error,
  }) : super(key: key);

  final Function? onRefresh;
  final ErrorModel? error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (error != null && error!.icon.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 0.05.sh),
              child: SvgPicture.asset(error!.icon),
            ),
          if (error != null)
            Text(
              error!.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                // color: AppLightTheme.primaryColor.withOpacity(.2),
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          if (onRefresh != null && !(error?.hideRetry ?? false))
            TextButton(
              child: Text(
                'إعادة المحاولة',
                style: TextStyle(color: WingsTheme.primaryColor),
              ),
              onPressed: () => onRefresh!(),
              // isPressed: false,
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
