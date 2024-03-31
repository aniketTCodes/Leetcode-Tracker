part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitEvent extends AuthEvent{}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

 LoginEvent({required this.email,required this.password});
}

class LogoutEvent extends AuthEvent{}

class SendVerificationEvent extends AuthEvent{}

class RegisterEvent extends AuthEvent{
  final String email;
  final String password;
  final String confirmPassword;
  RegisterEvent({required this.email,required this.password,required this.confirmPassword});
}

class GotoRegisterEvent extends AuthEvent{}

class GotoLoginEvent extends AuthEvent{}
