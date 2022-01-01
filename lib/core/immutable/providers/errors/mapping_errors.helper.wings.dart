import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../mutable/statics/error_asset.static.wings.dart';
import 'error.model.wings.dart';
import 'exceptions.wings.dart';

ErrorModel mapExceptionToMessage(Object exception) {
  switch (exception.runtimeType) {
    case ServerException:
      return ErrorModel(
        message: 'Error:ServerException'.tr,
        image: WingsErrorAssets.serverExceptionImage,
        icon: WingsErrorAssets.serverExceptionIcon,
        exception: ServerException(),
      );
    case CacheException:
      return ErrorModel(
        message: 'Error:CacheException'.tr,
        image: WingsErrorAssets.cacheExceptionImage,
        icon: WingsErrorAssets.cacheExceptionIcon,
        exception: CacheException(),
      );
    case NoContentException:
      return ErrorModel(
        message: 'Error:NoContentException'.tr,
        image: WingsErrorAssets.noContentExceptionImage,
        icon: WingsErrorAssets.noContentExceptionIcon,
        exception: NoContentException(),
      );
    case ConnectionException:
      return ErrorModel(
        message: 'Error:ConnectionException'.tr,
        image: WingsErrorAssets.connectionExceptionImage,
        icon: WingsErrorAssets.connectionExceptionIcon,
        exception: ConnectionException(),
      );
    case NotFoundException:
      return ErrorModel(
        message: 'Error:NotFoundException'.tr,
        image: WingsErrorAssets.notFoundExceptionImage,
        icon: WingsErrorAssets.notFoundExceptionIcon,
        exception: NotFoundException(),
      );
    case InvalidException:
      return ErrorModel(
        message: 'Error:InvalidException'.tr,
        image: WingsErrorAssets.invalidExceptionImage,
        icon: WingsErrorAssets.invalidExceptionIcon,
        exception: InvalidException(),
      );
    case ExpireException:
      return ErrorModel(
        message: 'Error:ExpireException'.tr,
        image: WingsErrorAssets.expireExceptionImage,
        icon: WingsErrorAssets.expireExceptionIcon,
        exception: ExpireException(),
      );
    case UserExistsException:
      return ErrorModel(
        message: 'Error:UserExistsException'.tr,
        image: WingsErrorAssets.expireExceptionImage,
        icon: WingsErrorAssets.expireExceptionIcon,
        exception: UserExistsException(),
      );
    case PasswordException:
      return ErrorModel(
        message: 'Error:PasswordException'.tr,
        image: WingsErrorAssets.passwordExceptionImage,
        icon: WingsErrorAssets.passwordExceptionIcon,
        exception: PasswordException(),
      );
    case UnauthenticatedException:
      return ErrorModel(
        message: 'Error:UnauthenticatedException'.tr,
        image: WingsErrorAssets.unauthenticatedExceptionImage,
        icon: WingsErrorAssets.unauthenticatedExceptionIcon,
        exception: UnauthenticatedException(),
      );
    case BlockedException:
      return ErrorModel(
        message: 'Error:BlockedException'.tr,
        image: WingsErrorAssets.blockedExceptionImage,
        icon: WingsErrorAssets.blockedExceptionIcon,
        exception: BlockedException(),
      );
    case EmptyException:
      return ErrorModel(
        message: 'Error:EmptyException'.tr,
        image: WingsErrorAssets.emptyExceptionImage,
        icon: WingsErrorAssets.emptyExceptionIcon,
        exception: EmptyException(),
      );
    default:
      return ErrorModel(
        message: 'Error:UnexpectedException'.tr,
        image: WingsErrorAssets.unexpectedErrorImage,
        icon: WingsErrorAssets.unexpectedErrorIcon,
        exception: UnexpectedException(),
      );
  }
}
