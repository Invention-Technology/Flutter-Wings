import 'dart:developer';

import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/remote/request.wings.dart';
import 'package:wings/core/mutable/remote/urls.wings.dart';
import 'package:wings/features/detail/model/details.model.dart';

class DetailsController extends WingsController {
  @override
  void onReady() async {
    super.onReady();

    model = DetailsModel();

    String url = '${WingsURL.posts}/${arguments['id']}';

    request = WingsRequest(
      url: url,
      shouldCache: true,
    );

    await getData();
  }
}
