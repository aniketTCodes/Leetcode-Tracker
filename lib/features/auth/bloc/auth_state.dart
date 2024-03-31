part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class LoginState extends AuthState {
  final bool hasErrors;
  final String? errorMessage;
  LoginState({required this.hasErrors, this.errorMessage});

  LoginState copyWith(bool hasErrors, String? errorMessage) {
    return LoginState(hasErrors: hasErrors, errorMessage: errorMessage);
  }
}

final class RegisterState extends AuthState {
  final bool hasErrors;
  final String? errorMessage;
  RegisterState({required this.hasErrors, this.errorMessage});

  RegisterState copyWith(bool hasErrors, String? errorMessage) {
    return RegisterState(hasErrors: hasErrors, errorMessage: errorMessage);
  }
}

final class AuthLoadingState extends AuthState {}

final class VerifyEmailState extends AuthState {
  final bool hasErrors;
  final String? errorMessage;
  VerifyEmailState({required this.hasErrors, this.errorMessage});

  VerifyEmailState copyWith(bool hasErrors, String? errorMessage) {
    return VerifyEmailState(hasErrors: hasErrors, errorMessage: errorMessage);
  }
}

final class AuthDoneState extends AuthState {}
