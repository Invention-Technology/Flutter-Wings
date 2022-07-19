import 'package:get/get.dart';
import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/remote/request.wings.dart';
import 'package:wings/core/mutable/remote/urls.wings.dart';
import 'package:wings/features/detail/model/details.model.dart';

class DetailsController extends WingsController {
  @override
  void onReady() async {
    model = DetailsModel();

    String url = WingsURL.posts + '/' + Get.arguments['id'].toString();

    request = WingsRequest(
      url: url,
      shouldCache: true,
    );

    await getData();
  }
}
