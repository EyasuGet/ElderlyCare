import 'dart:math';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/nurse_profile_repository.dart';
import '../../utils/auth_token.dart';
import '../../application/state/nurse_profile_state.dart';
import '../../application/events/nurse_profile_event.dart';
import '../../data/remote/request/nurse_profile_request.dart';

class NurseProfileViewModel extends StateNotifier<NurseProfileState> {
  final NurseProfileRepository repository;
  final SessionManager sessionManager;

  NurseProfileViewModel({
    required this.repository,
    required this.sessionManager,
  }) : super(NurseProfileState());

  void handleEvent(NurseProfileEvent event) {
    if (event is FetchNurseProfile) {
      fetchNurseProfile();
    } else if (event is OnNameChange) {
      state = state.copyWith(name: event.name);
    } else if (event is OnEmailChange) {
      state = state.copyWith(email: event.email);
    } else if (event is OnPhoneNumberChange) {
      state = state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is OnUserNameChange) {
      state = state.copyWith(userName: event.userName);
    } else if (event is OnYearsOfExperienceChange) {
      state = state.copyWith(yearsOfExperience: event.yearsOfExperience);
    } else if (event is OnSubmit) {
      updateProfile();
    }
  }

  Future<void> fetchNurseProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await sessionManager.fetchAuthToken();
      final nurseProfile = await repository.getNurseProfile(token!);
      state = state.copyWith(
        isLoading: false,
        name: nurseProfile.data.name,
        email: nurseProfile.data.email,
        phoneNumber: nurseProfile.data.phoneNo.isEmpty ? "+251 911 251 191" : nurseProfile.data.phoneNo,
        userName: nurseProfile.data.name.isEmpty ? "" : "@${nurseProfile.data.name.toLowerCase()}",
        yearsOfExperience: "+${Random().nextInt(5) + 1} years",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await sessionManager.fetchAuthToken();
      await repository.updateNurseProfile(
        token!,
        NurseProfileRequest(
          name: state.name,
          email: state.email,
          phoneNo: state.phoneNumber,
          userName: state.userName,
        ),
      );
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> clearSessionOnLogout() async {
    await sessionManager.clearSession();
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }
}