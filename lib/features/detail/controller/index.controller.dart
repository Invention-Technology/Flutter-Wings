import 'package:get/get.dart';
import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/remote/request.wings.dart';
import 'package:wings/core/mutable/remote/urls.wings.dart';
import 'package:wings/features/detail/model/index.model.dart';

class DetailController extends WingsController {
  @override
  void onInit() async {
    model = DetialModel();

    String url = WingsURL.posts + "/" + Get.arguments['id'].toString();

    request = WingsRequest(
      url: url,
      shouldCache: true,
    );

    await getData();

    super.onInit();
  }
}
