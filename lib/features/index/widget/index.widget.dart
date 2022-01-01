import 'package:flutter/material.dart';
import 'package:wings/core/immutable/base/widgets/widget.wings.dart';
import 'package:wings/features/index/watcher/index.watcher.dart';

class IndexWidget extends WingsWidget {
  final dynamic controller;

  IndexWidget({Key? key, this.controller})
      : super(key: key, watcher: IndexWatcher(controller: controller));

  @override
  Widget successState(BuildContext context) {
    return const Text('Wings Widget Example');
  }
}
