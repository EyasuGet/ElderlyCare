  import 'package:elderly_care/application/providers/repository_providers.dart';
  import 'package:flutter_riverpod/legacy.dart';
  import '../../data/repository/login_repository.dart';
  import '../../utils/auth_token.dart';
  import '../../application/state/login_state.dart';
  import '../../application/events/login_event.dart';

  // PROVIDER for ViewModel
  final loginViewModelProvider =
      StateNotifierProvider<LoginViewModel, LoginState>((ref) {
    final repository = ref.watch(loginRepositoryProvider);
    final sessionManager = ref.watch(sessionManagerProvider);
    return LoginViewModel(repository: repository, sessionManager: sessionManager);
  });

  class LoginViewModel extends StateNotifier<LoginState> {
    final LoginRepository repository;
    final SessionManager sessionManager;

    LoginViewModel({required this.repository, required this.sessionManager})
        : super(LoginState());

    void handleEvent(LoginEvent event) {
      if (event is OnEmailChange) {
        state = state.copyWith(email: event.email);
      } else if (event is OnPasswordChange) {
        state = state.copyWith(password: event.password);
      } else if (event is OnSubmit) {
        handleLogin(state.email, state.password);
      } else if (event is LogoutEvent) {
        logout();
      } else if (event is ClearLoginResults) {
        clearLoginResults();
      }
    }

    Future<void> handleLogin(String email, String password) async {
      state = state.copyWith(isLoading: true, error: null, isSuccess: false);
      try {
        final response = await repository.loginUser(email, password);
        final token = response.token ?? "";
        final role = response.role ?? "";
        await sessionManager.saveAuthToken(token);
        await sessionManager.saveUserRole(role);
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          role: role,
        );
      } catch (e) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          isSuccess: false,
        );
      }
    }
    
    void clearLoginResults() {
      state = LoginState();
    }

    void reset() {
      state = LoginState.initial();
    }

    Future<String?> fetchRole() async {
      return await sessionManager.fetchRole();
    }

    Future<void> logout() async {
      await sessionManager.clearSession();
      state = LoginState(logoutSuccess: true);
    }
  }