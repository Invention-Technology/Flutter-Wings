import 'dart:ui';

import '../providers/errors/error.model.wings.dart';

class WingsState {
  final bool isInitial;
  final bool isLoading;
  final bool isLoaded;
  final bool isSuccess;
  final bool isError;
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
  final String flushSuccessTitle;

  WingsState._({
    this.isErrorFlushBar = false,
    this.isInitial = false,
    this.isLoading = false,
    this.isLoaded = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorData,
    this.isSuccessFlushBar = false,
    this.flushErrorData,
    this.flushSuccessMessage = '',
    this.flushSuccessTitle = '',
  });

  factory WingsState.loading() {
    return WingsState._(isLoading: true);
  }

  factory WingsState.success() {
    return WingsState._(isSuccess: true);
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

  factory WingsState.errorFlushBar({ErrorModel? error}) {
    return WingsState._(isErrorFlushBar: true, flushErrorData: error!);
  }

  @override
  String toString() {
    if (isSuccessFlushBar) return 'SuccessFlushBar';
    if (isErrorFlushBar) return 'ErrorFlushBar';
    if (isError) return 'Error';
    if (isLoading) return 'Loading';
    if (isLoaded) return 'Loaded';
    if (isSuccess) return 'Success';

    return 'Initial';
  }
}
