import 'package:flutter/material.dart';
import 'package:wings/core/immutable/base/views/view.wings.dart';
import 'package:wings/features/detail/controller/details.controller.dart';

class DetailsView extends WingsView<DetailsController> {
  DetailsView({Key? key}) : super(key: key, controller: DetailsController());

  @override
  PreferredSizeWidget? pageAppBar(BuildContext context) {
    return AppBar(
      title: const Text('details'),
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
