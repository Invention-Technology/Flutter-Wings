import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:wings/core/immutable/base/views/view.wings.dart';
import 'package:wings/features/detail/controller/index.controller.dart';

class DetailView extends WingsView {
  DetailView({Key? key}) : super(key: key, controller: DetailController());

  @override
  PreferredSizeWidget? pageAppBar(BuildContext context) {
    return AppBar(
      title: Text("Error:ServerException".tr),
    );
  }

  @override
  Widget successState(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        controller.data.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        controller.data.body,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
