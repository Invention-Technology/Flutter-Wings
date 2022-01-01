import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wings/core/immutable/base/views/view.wings.dart';
import 'package:wings/features/detail/view/index.view.dart';
import 'package:wings/features/index/controller/index.controller.dart';

class IndexView extends WingsView<IndexController> {
  IndexView({Key? key}) : super(key: key, controller: IndexController());

  @override
  PreferredSizeWidget? pageAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Posts'),
    );
  }

  @override
  Widget successState(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                Get.to(() => DetailView(), arguments: {
                  'id': controller.posts[index].id,
                });
              },
              title: Text(
                controller.posts[index].title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
          ],
        );
      },
      itemCount: controller.posts.length,
    );
  }

  @override
  Widget floatingActionButton() {
    return FloatingActionButton(onPressed: () => controller.add());
  }
}
