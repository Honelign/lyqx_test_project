import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Server failures (API errors, network issues)
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Cache failures (local storage issues)
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

/// Validation failures (form validation)
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}