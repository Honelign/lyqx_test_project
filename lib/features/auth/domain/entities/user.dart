import 'package:equatable/equatable.dart';

/// User entity representing a user in the system
class User extends Equatable {
  final String? token;

  const User({this.token});

  @override
  List<Object?> get props => [token];
}
