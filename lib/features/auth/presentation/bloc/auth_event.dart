part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthSignupEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}
