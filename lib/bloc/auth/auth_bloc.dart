import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.onAuthenticationChanged})
      : super(AuthenticationUninitialized()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<AuthenticationLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationLoggedOut>(_onAuthenticationLoggedOut);
    on<AuthenticationError>(
        (event, emit) => emit(AuthenticationErrorx(event.message)));
    on<AuthenticationTokenRefreshed>(
        (event, emit) => _onAuthenticationTokenRefreshed(event, emit));
  }

  final ValueChanged<AuthenticationState> onAuthenticationChanged;

  Future<void> _onAuthenticationStarted(
      AuthenticationStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final currentUser = await _getCurrentUser();
      if (currentUser != null) {
        onAuthenticationChanged(AuthenticationAuthenticated(currentUser));
        emit(AuthenticationAuthenticated(currentUser));
      } else {
        onAuthenticationChanged(AuthenticationUnauthenticated());
        emit(AuthenticationUnauthenticated());
      }
    } catch (e) {
      print(e);
      emit(AuthenticationErrorx(e.toString()));
    }
  }

  void _onAuthenticationLoggedIn(
      AuthenticationLoggedIn event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationAuthenticated(event.user));
    onAuthenticationChanged(AuthenticationAuthenticated(event.user));
  }

  void _onAuthenticationLoggedOut(AuthenticationLoggedOut, Emitter emit) {
    emit(AuthenticationUnauthenticated());
    onAuthenticationChanged(AuthenticationUnauthenticated());
  }

  Future _onAuthenticationTokenRefreshed(
      AuthenticationTokenRefreshed event, Emitter emit) async {
    emit(AuthenticationAuthenticated(event.user));
    onAuthenticationChanged(AuthenticationAuthenticated(event.user));
  }

  Future _getCurrentUser() async {
// Your authentication logic here.
// Return null if the user is not authenticated. Otherwise, return a User object.
  }
}
