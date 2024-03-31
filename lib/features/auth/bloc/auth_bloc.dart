import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/auth/data/repository/auth_repository.dart';
import 'package:leetcode_tracker/features/auth/data/service/auth_service.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev show log;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final repo = AuthRepository(AuthService());
  final _firebaseAuth = getIt<FirebaseAuth>();
  AuthBloc() : super(LoginState(hasErrors: false)) {
    on<GotoRegisterEvent>(
      (event, emit) => emit(
        RegisterState(hasErrors: false),
      ),
    );

    on<GotoLoginEvent>(
      (event, emit) => emit(
        LoginState(hasErrors: false),
      ),
    );

    on<RegisterEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        if (event.email.isEmpty) {
          emit(RegisterState(
              hasErrors: true, errorMessage: 'Email cannot be empty!'));
          return;
        }
        if (event.password.isEmpty) {
          emit(RegisterState(
              hasErrors: true, errorMessage: 'Password cannot be empty!'));
          return;
        }
        if (event.password != event.confirmPassword) {
          emit(RegisterState(
              hasErrors: true, errorMessage: 'Password does not match!'));
          return;
        }
        final result = await repo.register(event.email, event.password);
        result.fold(
          (l) => emit(
            RegisterState(
              hasErrors: true,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            VerifyEmailState(
              hasErrors: false,
            ),
          ),
        );
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        if (event.email.isEmpty) {
          emit(LoginState(
              hasErrors: true, errorMessage: 'Email cannot be empty'));
          return;
        }
        if (event.password.isEmpty) {
          emit(LoginState(
              hasErrors: true, errorMessage: 'Password cannot be empty'));
          return;
        }
        emit(AuthLoadingState());
        final result =
            await repo.loginWithEmailPassword(event.email, event.password);
        result.fold(
            (l) => emit(LoginState(hasErrors: true, errorMessage: l.message)),
            (r) {
          if (r.emailVerified) {
            emit(AuthDoneState());
          } else {
            emit(VerifyEmailState(hasErrors: false));
          }
        });
      },
    );

    on<SendVerificationEvent>(
      (event, emit) async {
        await repo.verifyUserEmail();
        User user = FirebaseAuth.instance.currentUser!;
        while (user.emailVerified == false) {
          await user.reload();
          user = FirebaseAuth.instance.currentUser!;
        }
        emit(AuthDoneState());
      },
    );

    on<AuthInitEvent>((event, emit) => _onAuthInit(event, emit));
  }

  _onAuthInit(AuthInitEvent event, Emitter<AuthState> emit) {
    final userData = _firebaseAuth.currentUser;
    if (userData == null) {
      emit(LoginState(hasErrors: false));
      return;
    }
    if (userData.emailVerified) {
      emit(AuthDoneState());
    } else {
      emit(VerifyEmailState(hasErrors: false));
    }
  }
}
