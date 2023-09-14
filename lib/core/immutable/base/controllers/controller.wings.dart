import 'dart:developer';

import 'package:wings/core/mutable/helpers/loading.dialog.helper.dart';
import 'package:wings/features/auth/controller/auth.dart';

import '../../../mutable/remote/urls.wings.dart';
import '../../../mutable/statics/error_asset.static.wings.dart';
import '../../../mutable/stores/store.wings.dart';
import '../../base/models/model.wings.dart';
import '../../binding/reactive.binding.dart';
import '../../main.wings.dart';
import '../../providers/errors/error.model.wings.dart';
import '../../providers/errors/exceptions.wings.dart';
import '../../providers/remote/methods.enums.wings.dart';
import '../../providers/remote/remote.wings.dart';
import '../../providers/remote/request.wings.dart';
import '../../states/state.wings.dart';
import '../middlewares/middleware.wings.dart';
import '../models/response.model.wings.dart';

class WingsController {
  WingsController() {
    fillMiddlewares();

    state.stream.listen((state) {
      log('State has changed to $state', name: child.runtimeType.toString());
      onStatusChanged();
    });

    onInit();
  }

  static WingsController? _instance;

  static WingsController get instance {
    _instance ??= WingsController();

    return _instance!;
  }

  Map<String, dynamic> arguments = {};

  List<WingsMiddleware> middlewares = [];

  /// The model that the API data came to
  WingsModel? model;

  Type get type => model.runtimeType;

  /// The state of the widget
  var state = WingsState.loading().wis;

  /// call to WingsStore to use it globally
  WingsStore get store => WingsStore.instance;

  /// This variable will contain the response data so it can be called from WingsView
  late dynamic data;

  dynamic get child => this;

  WingsRequest request = WingsRequest(url: '');
  WingsRequest _originalRequest = WingsRequest(url: '');

  String get customKey => '';

  WingsResponseModel? responseModel;

  int currentPaginationPage = 0;

  bool lastPage = false;

  bool busy = false;

  void onInit() async {
    saveMainRequest();

    if (request.url.isNotEmpty) {
      await getData();
    }
  }

  void onReady() {
    if (Wings.arguments.isNotEmpty) {
      arguments = Wings.arguments;
      Wings.arguments = {};
    }
  }

  Future<void> getData({
    WingsRequest? request,
    WingsState? loadingState,
    WingsState? errorState,
    bool fillGlobalData = true,
    bool acceptErrors = false,
    Function(dynamic data)? onSuccess,
    Function()? onError,
    bool showFlushBar = false,
    String? flushBarMessage,
    bool useModel = true,
    bool noLoading = false,
  }) async {
    if (busy) return;

    busy = true;

    WingsRequest req = request ?? this.request;

    if (req.url.isEmpty) return;

    if (!noLoading) {
      state.value = loadingState ?? WingsState.loading();
    }

    await WingsRemoteProvider().send(
      request: req,
      method: WingsRemoteMethod.get,
      onError: (statusCode, error) async {
        busy = false;

        if (onError != null) {
          onError();
        }

        if (state.value.isLoadingMore) {
          closeLoadingDialog();
        }

        if (acceptErrors) {
          state.value = WingsState.success();
        } else {
          _fillStateWithError(
            statusCode: statusCode,
            errorState: errorState,
            error: error,
          );
        }
      },
      onSuccess: (response, status) {
        busy = false;

        responseModel = WingsResponseModel.fromResponse(response);
        var res = responseModel?.data;
        dynamic data;

        if (customKey.isNotEmpty) {
          res = res[customKey];
        }

        if (model != null && useModel) {
          if (res is List) {
            data = model!.fromJsonList(res);

            if (data.isEmpty) {
              throw EmptyException();
            }
          } else if (res is Map<String, dynamic>) {
            data = model!.fromJson(res);
          } else {
            data = res;
          }
        } else {
          data = res;
        }

        if (fillGlobalData) {
          this.data = data;
        }

        if (state.value.isLoadingMore) {
          closeLoadingDialog();
        }

        if (onSuccess != null) {
          onSuccess(data);
        }

        if (showFlushBar || flushBarMessage != null) {
          state.value = WingsState.successFlushBar(
              message: flushBarMessage ?? 'تمت العملية بنجاح');
        }

        state.value = WingsState.success();
      },
    );
  }

  Future<dynamic> sendData(
      {List? toList,
      bool showFlushBar = false,
      bool showLoadingState = true,
      bool showErrorState = true,
      bool showSuccessState = true,
      bool dontChangeState = false,
      bool useModel = true,
      WingsRemoteMethod method = WingsRemoteMethod.post,
      WingsState? loadingState,
      WingsState? errorState,
      WingsRequest? request,
      Function(dynamic data)? onSuccess,
      Function()? onError,
      WingsModel? model,
      bool backOnSuccess = false,
      String? flushBarMessage}) async {
    if (busy) return;
    busy = true;

    dynamic temp;

    WingsRequest req = request ?? this.request;

    if (useModel) {
      model ??= this.model;
    }

    if (loadingState != null) {
      state.value = loadingState;
    }

    await WingsRemoteProvider().send(
        request: req,
        method: method,
        onSuccess: (response, status) {
          busy = false;

          var res = WingsResponseModel.fromResponse(response);
          responseModel = res;

          if (model != null) {
            if (res.data is Map<String, dynamic>) {
              temp = model.fromJson(res.data);
              if (toList != null) {
                toList.add(temp);
              }
            } else {
              temp = res.data;
            }
          } else {
            temp = res.data;
          }

          if (state.value.isLoadingMore) {
            closeLoadingDialog();
          }

          if (onSuccess != null) {
            onSuccess(temp);
          }

          if (showFlushBar || flushBarMessage != null) {
            state.value = WingsState.successFlushBar(
                message: flushBarMessage ?? 'تمت الإضافة بنجاح');
          } else if (showSuccessState || !dontChangeState) {
            state.value = WingsState.success();
          }

          if (backOnSuccess) {
            Wings.pop();
          }
        },
        onError: (statusCode, error) {
          busy = false;

          if (onError != null) {
            onError();
          }

          if (state.value.isLoadingMore) {
            closeLoadingDialog();
          }

          _fillStateWithError(
            statusCode: statusCode,
            errorState: errorState,
            dontChangeState: dontChangeState,
            error: error,
          );
        });

    return temp;
  }

  ErrorModel? emptyException;

  void errorEmptyException() {
    emptyException = ErrorModel(
      message: 'لا توجد بيانات في الوقت الحالي',
      icon: WingsErrorAssets.emptyExceptionIcon,
    );

    state.value = WingsState.error(error: emptyException);
  }

  void fillMiddlewares() {
    middlewares = [];
  }

  void onStatusChanged() {}

  Future<void> refresh() async {
    restoreMainRequest();

    await getData();
  }

  void saveMainRequest() {
    _originalRequest = request;
  }

  void restoreMainRequest() {
    request = _originalRequest;
  }

  void refreshStatus() async {
    state.value = WingsState.success();
  }

  void onDispose() {}

  Future<void> nextPage() async {
    lastPage = true;
    if (responseModel != null && responseModel?.pages != null) {
      var pages = int.tryParse(responseModel!.pages.toString());
      if (pages != null && pages > currentPaginationPage) {
        request = request.copyWith(
            queryString: Map.from(request.queryString)
              ..addAll({'page': currentPaginationPage + 1}));

        await getData(
          acceptErrors: true,
          fillGlobalData: false,
          noLoading: true,
          onError: () {
            lastPage = true;
            state.value = WingsState.success();
          },
          onSuccess: (data) {
            onPaginationSuccess(data);

            currentPaginationPage++;
            lastPage = false;
          },
        );

        return;
      }
    }

    lastPage = true;
    state.value = WingsState.success();
  }

  void onPaginationSuccess(dynamic data) {
    this.data.addAll(data);
  }

  void resetPagination() {
    lastPage = false;
    currentPaginationPage = 0;
    request = request.copyWith(
        queryString: Map.from(request.queryString)..addAll({'page': 0}));
  }

  Future<void> refreshFirstPage() async {
    if (currentPaginationPage > 0) {
      var req = request.copyWith(
          queryString: Map.from(request.queryString)..addAll({'page': 0}));

      await getData(
        request: req,
        loadingState: WingsState.success(),
        acceptErrors: true,
        fillGlobalData: false,
        onSuccess: (data) {
          try {
            onRefreshFirstPageSuccess(data);
          } catch (ex) {
            log("$ex", name: 'Wings Controller: Refresh First Page');
          }
        },
      );
    } else {
      getData(loadingState: WingsState.success());
    }
  }

  void onRefreshFirstPageSuccess(dynamic data) {
    if (data is List &&
        data.isNotEmpty &&
        this.data is List &&
        this.data.isNotEmpty) {
      int index = data.indexWhere(
        (element) => element.id == this.data.first.id,
      );

      for (var i = 0; i < index; i++) {
        this.data.insert(0, data[i]);
      }

      if (index == -1) {
        this.data.transactionList.insertAll(0, data);
      }
    }
  }

  bool checkTokenExpiration(int statusCode) {
    return statusCode.toException is UnauthenticatedException &&
        Auth().loggedIn;
  }

  Future<void> refreshToken(Function()? onSuccess) async {
    var tempModel = model;
    model = null;

    await getData(
        request: WingsRequest(url: WingsURL.baseImageURL),
        acceptErrors: true,
        onSuccess: (data) async {
          Auth().updateToken(data['token']);
          model = tempModel;
          if (onSuccess != null) {
            onSuccess();
          }
          return;
        });
  }

  void _fillStateWithError({
    required int statusCode,
    WingsState? errorState,
    dynamic error,
    bool dontChangeState = false,
  }) {
    String message = '';

    try {
      message = error?['Messages'] ?? '';
    } catch (ex) {
      message = '';
    }

    final errorModel = error is EmptyException
        ? emptyException
        : ErrorModel(
            exception: statusCode.toException,
            icon: 'assets/icons/states/empty.svg',
            message: message,
          );

    if (errorState != null) {
      if (errorState.isError && !dontChangeState) {
        state.value = WingsState.error(error: errorModel);
      } else if (errorState.isErrorFlushBar) {
        state.value = WingsState.errorFlushBar(error: errorModel);
      } else if (!dontChangeState) {
        state.value = errorState;
      }
    } else if (!dontChangeState) {
      state.value = WingsState.error(error: errorModel);
    }
  }
}
