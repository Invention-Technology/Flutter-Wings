import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/theme.wings.dart';

class MainPagesWidget extends StatelessWidget {
  final List<Widget> children;

  const MainPagesWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: WingsTheme.pagePadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.search,
                size: 32.sp,
              ),
              Text(
                'هيفي',
                style: WingsTheme.bigHeading600,
              ),
              Icon(
                Icons.supervised_user_circle_outlined,
                size: 32.sp,
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

}