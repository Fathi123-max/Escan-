import 'package:escan/data/model/usermodel.dart';

abstract class AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final User user;

  AuthenticationLoggedIn(this.user);
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationError extends AuthenticationEvent {
  final String message;

  AuthenticationError(this.message);
}

class AuthenticationTokenRefreshed extends AuthenticationEvent {
  final User user;

  AuthenticationTokenRefreshed(this.user);
}
