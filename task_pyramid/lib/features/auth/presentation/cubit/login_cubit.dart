import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login login;
  LoginCubit({required this.login}) : super(LoginInitial());
  LoginResponse? _loginResponse;
  LoginParams loginParams = LoginParams();

  Future<void> userLogin(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(LoginLoading());
      final failOrUser = await login(loginParams);
      failOrUser.fold((fail) {
        String message = fail is ServerFailure ? fail.message : "Error happend";
        emit(LoginError(message: message));
      }, (user) {
        _loginResponse = user;
        log(_loginResponse.toString());
        loginParams = LoginParams();
        emit(LoginSuccess());
      });
    }
  }
}
