import 'package:elderly_care/application/state/care_schedule_state.dart';
import 'package:elderly_care/application/state/login_state.dart';
import 'package:elderly_care/application/state/nurse_delete_state.dart';
import 'package:elderly_care/application/state/nurse_list_state.dart';
import 'package:elderly_care/application/state/nurse_profile_state.dart';
import 'package:elderly_care/application/state/schedule_state.dart';
import 'package:elderly_care/application/state/signup_state.dart';
import 'package:elderly_care/application/state/user_edit_profile_state.dart';
import 'package:elderly_care/application/state/view_detail_state.dart';
import 'package:elderly_care/domain/models/care_schedule_viewmodel.dart';
import 'package:elderly_care/domain/models/nurse_delete_viewmodel.dart';
import 'package:elderly_care/domain/models/nurse_list_viewmodel.dart';
import 'package:elderly_care/domain/models/nurse_profile_viewmodel.dart';
import 'package:elderly_care/domain/models/schedule_viewmodel.dart';
import 'package:elderly_care/domain/models/user_profile_viewmodel.dart';
import 'package:elderly_care/domain/models/view_detail_viewmodel.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/signup_viewmodel.dart';
import '../../domain/models/login_viewmodel.dart';
import 'repository_providers.dart';

final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  return SignUpViewModel(repository: ref.watch(signUpRepositoryProvider));
});

final loginViewModelProvider = StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(
    repository: ref.watch(loginRepositoryProvider),
    sessionManager: ref.watch(sessionManagerProvider),
  );
});


final nurseListViewModelProvider = StateNotifierProvider.autoDispose<NurseListViewModel, NurseListState>((ref) {
  final repo = ref.watch(nurseRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return NurseListViewModel(repository: repo, sessionManager: session);
});

final scheduleViewModelProvider = StateNotifierProvider<ScheduleViewModel, ScheduleState>((ref) {
  final repository = ref.watch(scheduleRepositoryProvider);
  final sessionManager = ref.watch(sessionManagerProvider);
  return ScheduleViewModel(repository: repository, sessionManager: sessionManager);
});

final userProfileViewModelProvider = StateNotifierProvider.autoDispose<UserProfileViewModel, UserEditProfileState>((ref) {
  final repo = ref.watch(userProfileRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return UserProfileViewModel(repository: repo, sessionManager: session);
});

final careScheduleViewModelProvider =
    StateNotifierProvider<CareScheduleViewModel, CareScheduleState>((ref) {
  final repo = ref.watch(careScheduleRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return CareScheduleViewModel(repository: repo, sessionManager: session);
});

final nurseProfileViewModelProvider = StateNotifierProvider<NurseProfileViewModel, NurseProfileState>((ref) {
  final repo = ref.watch(nurseProfileRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return NurseProfileViewModel(repository: repo, sessionManager: session);
});

final viewDetailViewModelProvider = StateNotifierProvider.autoDispose
    <ViewDetailViewModel, ViewDetailState>((ref) {
  final repo = ref.watch(viewDetailRepositoryProvider);
  final loginRepo = ref.watch(loginRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return ViewDetailViewModel(
    viewDetailRepository: repo,
    sessionManager: session,
    loginRepository: loginRepo,
  );
});

final nurseDeleteViewModelProvider = StateNotifierProvider.autoDispose<NurseDeleteViewModel, NurseDeleteState>((ref) {
  final repo = ref.watch(nurseDeleteRepositoryProvider);
  final session = ref.watch(sessionManagerProvider);
  return NurseDeleteViewModel(nurseDeleteRepository: repo, sessionManager: session);
});