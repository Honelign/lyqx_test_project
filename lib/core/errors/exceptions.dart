/// Base exception class
class AppException implements Exception {
  final String message;
  
  AppException(this.message);
  
  @override
  String toString() => message;
}

/// Server exception for API errors
class ServerException extends AppException {
  final int? statusCode;
  
  ServerException(String message, {this.statusCode}) : super(message);
}

/// Cache exception for local storage errors
class CacheException extends AppException {
  CacheException(String message) : super(message);
}

/// Authentication exception
class AuthException extends AppException {
  AuthException(String message) : super(message);
}