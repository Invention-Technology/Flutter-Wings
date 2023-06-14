import 'package:flutter/material.dart';
import 'package:wings/core/mutable/helpers/util.helper.dart';
import 'package:wings/core/mutable/themes/theme.wings.dart';
import 'package:wings/core/mutable/widgets/utils.widget.dart';

import '../../immutable/main.wings.dart';
import 'svg.widget.dart';

PreferredSizeWidget? wingsDefaultAppbar(
  BuildContext context, {
  String? title,
  List<Widget>? actions,
}) {
  if (ModalRoute.of(context)?.isFirst == true) {
    return wingsFirstAppbar(context);
  }

  return wingsCanBackAppbar(context, title: title, actions: actions);
}

PreferredSizeWidget? wingsFirstAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: WingsTheme.scaffoldBackgroundColor,
    elevation: 0,
    actions: const [],
    leading: Padding(
      padding: EdgeInsetsDirectional.only(start: 0.03.wsh),
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: SvgWidget(
          'menu.svg',
          color: WingsTheme.secondaryColor,
        ),
      ),
    ),
  );
}

PreferredSizeWidget? wingsCanBackAppbar(
  BuildContext context, {
  String? title,
  List<Widget>? actions,
}) {
  if (title == null || title.isEmpty) return null;

  return AppBar(
    title: GestureDetector(
      onTap: () => Wings.pop(),
      child: title.toBody1Point5Text,
    ),
    leading: GestureDetector(
      onTap: () => Wings.pop(),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 0.03.wsh),
        child: Icon(
          Icons.arrow_back_ios,
          color: WingsTheme.secondaryColor,
          size: 0.025.wsh,
        ),
      ),
    ),
    actions: actions,
    backgroundColor: WingsTheme.scaffoldBackgroundColor,
    elevation: 0,
  );
}
