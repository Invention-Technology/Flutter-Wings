import 'package:flutter/material.dart';

import '../../immutable/main.wings.dart';

dynamic bottomSheetHelper({
  required Widget Function(BuildContext) builder,
}) {
  Wings.isView = false;

  return showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
    context: Wings.context,
    builder: builder,
  );
}
