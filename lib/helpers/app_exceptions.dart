class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}

class InternalErrorException extends AppException {
  InternalErrorException([String message]) : super(message, "");
}

class ForbiddenException extends AppException {
  ForbiddenException([String message]) : super(message, "");
}

class ConflictException extends AppException {
  ConflictException([String message]) : super(message, "");
}
class PreconditionFailedException extends AppException {
  PreconditionFailedException([String message]) : super(message, "");
}