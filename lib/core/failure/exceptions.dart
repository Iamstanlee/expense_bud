class CacheException implements Exception {}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = "An unexpected errror occured"]);
}

class InvalidInputException implements Exception {}

class InvalidArgException implements Exception {}

class NoNetworkException implements Exception {}
