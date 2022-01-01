import 'exceptions.enum.wings.dart';

class WingsException implements Exception {
  WingsException();

  factory WingsException.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 204:
        return NoContentException();
      case 401:
        return UnauthenticatedException();
      case 404:
        return NotFoundException();
      case 406:
        return InvalidException();
      case 410:
        return ExpireException();
      case 434:
        return UserExistsException();
      case 439:
        return BlockedException();
      case 500:
        return ServerException();
      default:
        return UnexpectedException();
    }
  }

  factory WingsException.fromEnumeration(ExceptionTypes types) {
    switch (types) {
      case ExceptionTypes.cache:
        return CacheException();
      case ExceptionTypes.process:
        return ProcessException();
      case ExceptionTypes.connection:
        return ConnectionException();
      case ExceptionTypes.timeout:
        return TimeoutException();
      case ExceptionTypes.empty:
        return EmptyException();
      case ExceptionTypes.unexpected:
        return UnexpectedException();
    }
  }
}

class ServerException extends WingsException {}

class CacheException extends WingsException {}

class EmptyException extends WingsException {}

class NoContentException extends WingsException {}

class InvalidException extends WingsException {}

class NotFoundException extends WingsException {}

class ExpireException extends WingsException {}

class UserExistsException extends WingsException {}

class PasswordException extends WingsException {}

class UnexpectedException extends WingsException {}

class UnauthenticatedException extends WingsException {}

class BlockedException extends WingsException {}

class ConnectionException extends WingsException {}

class ProcessException extends WingsException {}

class TimeoutException extends WingsException {}
