import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wings/core/immutable/main.wings.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';
import 'package:wings/core/mutable/widgets/svg.widget.dart';

class WingsDefaultDrawerWidget extends StatelessWidget {
  const WingsDefaultDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.75.sw,
      height: double.infinity,
      color: Colors.white,
      child: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget _navItem({
    required String title,
    required String icon,
    required dynamic page,
  }) {
    return GestureDetector(
      onTap: () {
        Wings.pop(removeLast: false);
        Wings.push(page());
      },
      child: Column(
        children: [
          ListTile(
            leading: SvgWidget(
              icon,
              color: WingsTheme.secondaryColor,
              height: 0.0375.wsh,
            ),
            title: Text(
              title,
              style: WingsTheme.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            color: WingsTheme.secondTextColor,
            height: 2,
            thickness: 0.1,
            indent: 0.05.sw,
            endIndent: 0.1.sw,
          ),
        ],
      ),
    );
  }
}
