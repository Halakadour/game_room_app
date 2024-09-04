class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class UnauthenticatedExeption implements Exception {}
