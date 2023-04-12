import 'package:escan/data/model/usermodel.dart';

abstract class AuthenticationState {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated(this.user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationErrorx extends AuthenticationState {
  final String message;

  AuthenticationErrorx(this.message);
}

extension AuthenticationStateX on AuthenticationState {
  bool get isLoading => this is AuthenticationLoading;

  bool get isAuthenticated => this is AuthenticationAuthenticated;

  bool get isUnauthenticated => this is AuthenticationUnauthenticated;

  bool get isError => this is AuthenticationErrorx;
}
