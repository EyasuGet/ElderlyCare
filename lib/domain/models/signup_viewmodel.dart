import 'package:elderly_care/application/providers/repository_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../application/state/signup_state.dart';
import '../../application/events/signup_event.dart';
import '../../data/repository/signup_repository.dart';

// 1. Provider
final signUpViewModelProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
  (ref) => SignUpViewModel(repository: ref.watch(signUpRepositoryProvider)),
);

// 2. ViewModel
class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpRepository repository;

  SignUpViewModel({required this.repository}) : super(SignUpState());

  void handleEvent(SignUpEvent event) {
    if (event is OnNameChange) {
      state = state.copyWith(name: event.name);
    } else if (event is OnPassword) {
      state = state.copyWith(password: event.password);
    } else if (event is OnEmailChange) {
      state = state.copyWith(email: event.email);
    } else if (event is OnRoleChange) {
      state = state.copyWith(role: event.role);
    } else if (event is OnConfirmPassword) {
      state = state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is ClearSignupResults) {
      clearSignupResults();
    } else if (event is OnSubmit) {
      if (state.role == "USER") {
        signUpUser(state.email, state.password, state.name);
      } else {
        signUpNurse(state.email, state.password, state.name);
      }
    }
  }

  Future<void> signUpUser(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await repository.signUpUser(email, password, name);
      state = state.copyWith(isLoading: false, isSuccess: true, isSignedUp: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), isSuccess: false);
    }
  }

  Future<void> signUpNurse(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await repository.signUpNurse(email, password, name);
      state = state.copyWith(isLoading: false, isSuccess: true, isSignedUp: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), isSuccess: false);
    }
  }

  void clearSignupResults() {
    state = SignUpState();
  }
}