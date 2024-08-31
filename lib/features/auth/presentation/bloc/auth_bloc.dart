import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp usersignup})
      : _userSignUp = usersignup,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final res = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });
  }
}
