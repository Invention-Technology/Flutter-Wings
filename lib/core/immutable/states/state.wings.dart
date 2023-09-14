import 'dart:ui';

import '../providers/errors/error.model.wings.dart';

class WingsState {
  final bool isInitial;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isLoaded;
  final bool isSuccess;
  final bool isError;
  final bool isEmpty;
  final bool isSuccessFlushBar;
  final bool isErrorFlushBar;
  ErrorModel? errorData = ErrorModel(
    message: '',
    borderColor: const Color(0xffFF434F),
    backgroundColor: const Color(0xffFEE8E9),
  );
  ErrorModel? flushErrorData = ErrorModel(
    message: '',
    borderColor: const Color(0xffFF434F),
    backgroundColor: const Color(0xffFEE8E9),
  );
  final String flushSuccessMessage;

  WingsState._({this.isErrorFlushBar = false,
    this.isInitial = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isLoaded = false,
    this.isEmpty = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorData,
    this.isSuccessFlushBar = false,
    this.flushErrorData,
    this.flushSuccessMessage = ''});

  factory WingsState.loading() {
    return WingsState._(isLoading: true);
  }

  factory WingsState.loadingMore() {
    return WingsState._(isLoadingMore: true);
  }

  factory WingsState.success() {
    return WingsState._(isSuccess: true);
  }

  factory WingsState.empty({ErrorModel? error}) {
    return WingsState._(isEmpty: true, errorData: error);
  }

  factory WingsState.error({ErrorModel? error}) {
    return WingsState._(isError: true, errorData: error);
  }

  factory WingsState.initial() {
    return WingsState._(isInitial: true);
  }

  factory WingsState.loaded() {
    return WingsState._(isLoaded: true);
  }

  factory WingsState.successFlushBar({message}) {
    return WingsState._(
      isSuccessFlushBar: true,
      flushSuccessMessage: message,
    );
  }

  factory WingsState.errorFlushBar({ErrorModel? error, String? message}) {
    if (error == null && message != null) {
      error = ErrorModel(message: message);
    }

    return WingsState._(isErrorFlushBar: true, flushErrorData: error);
  }

  @override
  String toString() {
    if (isSuccessFlushBar) return 'SuccessFlushBar';
    if (isErrorFlushBar) return 'ErrorFlushBar';
    if (isEmpty) return 'Empty';
    if (isError) return 'Error';
    if (isLoading) return 'Loading';
    if (isLoadingMore) return 'LoadingMore';
    if (isLoaded) return 'Loaded';
    if (isSuccess) return 'Success';

    return 'Initial';
  }
}
