import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/remote/request.wings.dart';
import 'package:wings/core/mutable/remote/urls.wings.dart';
import 'package:wings/features/index/model/index.model.dart';

class IndexController extends WingsController {
  List<IndexModel> get posts => data;

  @override
  void onInit() async {
    model = IndexModel();

    request = WingsRequest(url: WingsURL.posts, shouldCache: true);

    super.onInit();
  }

  Future<void> add() async {
    request.body = {
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    };

    await sendData(toList: data);
  }
}
