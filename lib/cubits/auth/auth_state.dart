import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String uid;
  final String email;
  final String? displayName;
  final bool emailVerified;

  const AuthAuthenticated({
    required this.uid,
    required this.email,
    this.displayName,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [uid, email, displayName, emailVerified];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthEmailVerificationRequired extends AuthState {
  final String email;

  const AuthEmailVerificationRequired(this.email);

  @override
  List<Object?> get props => [email];
}
