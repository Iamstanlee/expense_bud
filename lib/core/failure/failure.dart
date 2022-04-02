import 'package:expense_bud/core/failure/exceptions.dart';

abstract class Failure {
  String get msg;
}

class ServerFailure extends Failure {
  final Exception _exception;
  ServerFailure(this._exception);
  @override
  String get msg {
    switch (_exception.runtimeType) {
      case NoNetworkException:
        return "No internet connection";
      default:
        return "An unexpected error occured";
    }
  }
}

class CacheGetFailure extends Failure {
  @override
  String get msg => "Error getting entries from device";
}

class CachePutFailure extends Failure {
  @override
  String get msg => "Error saving entry to device";
}
