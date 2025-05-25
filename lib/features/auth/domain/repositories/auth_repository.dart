import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Logs in a user with [username] and [password]
  /// 
  /// Returns [User] on success
  /// Returns [Failure] on error
  Future<Either<Failure, User>> login(String username, String password);
}