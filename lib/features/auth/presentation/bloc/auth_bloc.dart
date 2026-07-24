import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_with_email.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_out.dart';
import '../../../../core/usecases/usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  final SignInWithEmail _signInWithEmail;
  final RegisterWithEmail _registerWithEmail;
  final SignOut _signOut;
  StreamSubscription<AppUser?>? _authSubscription;
  AuthBloc({required AuthRepository repository, required SignInWithEmail signInWithEmail, required RegisterWithEmail registerWithEmail, required SignOut signOut})
      : _repository = repository, _signInWithEmail = signInWithEmail, _registerWithEmail = registerWithEmail, _signOut = signOut, super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthSignInWithEmail>(_onSignInWithEmail);
    on<AuthRegister>(_onRegister);
    on<AuthSignOut>(_onSignOut);
    on<AuthSendPasswordReset>(_onPasswordReset);
  }
  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    // Checking _repository.currentUser synchronously here is a known race
    // condition: right after app launch, Firebase Auth's SDK may not have
    // finished restoring the persisted session from local storage yet, so
    // .currentUser can briefly read null even though the user is genuinely
    // still logged in — showing the login screen for someone who shouldn't
    // see it. Waiting for the first authStateChanges() event instead
    // correctly reflects Firebase's actual restored session state.
    try {
      final user = await _repository.authStateChanges.first
          .timeout(const Duration(seconds: 5));
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      // If the stream doesn't fire in time (e.g. genuinely offline on
      // first launch), fall back to the synchronous check rather than
      // leaving the user stuck.
      final current = _repository.currentUser;
      if (current != null) {
        emit(AuthAuthenticated(current));
      } else {
        emit(const AuthUnauthenticated());
      }
    }
  }
  Future<void> _onSignInWithEmail(AuthSignInWithEmail event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _signInWithEmail(SignInParams(email: event.email, password: event.password));
    result.fold((f) => emit(AuthError(f.message)), (u) => emit(AuthAuthenticated(u)));
  }
  
  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _registerWithEmail(RegisterParams(name: event.name, email: event.email, password: event.password));
    result.fold((f) => emit(AuthError(f.message)), (u) => emit(AuthAuthenticated(u)));
  }
  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    await _signOut(const NoParams()); emit(const AuthUnauthenticated());
  }
  Future<void> _onPasswordReset(AuthSendPasswordReset event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await _repository.sendPasswordReset(event.email);
    result.fold((f) => emit(AuthError(f.message)), (_) => emit(const AuthPasswordResetSent()));
  }
  @override
  Future<void> close() { _authSubscription?.cancel(); return super.close(); }
}