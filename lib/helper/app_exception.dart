
class AppException implements Exception {
  final String? _massage;
  final String? _prefix;

  AppException([this._massage, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_massage';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? massage]) : super(massage, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? massage]) : super(massage, 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? massage]) : super(massage, 'Unauthorised Request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? massage]) : super(massage, 'Invalid Input');
}
