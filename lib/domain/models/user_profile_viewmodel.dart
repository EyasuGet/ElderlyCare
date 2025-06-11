import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/user_profile_repository.dart';
import '../../data/remote/request/user_edit_profile_request.dart';
import '../../utils/auth_token.dart';
import '../../application/state/user_edit_profile_state.dart';
import '../../application/events/user_edit_profile_event.dart';

class UserProfileViewModel extends StateNotifier<UserEditProfileState> {
  final UserProfileRepository repository;
  final SessionManager sessionManager;

  UserProfileViewModel({required this.repository, required this.sessionManager})
      : super(UserEditProfileState()) {
    onEvent(LoadProfile());
  }

  void onEvent(UserEditProfileEvent event) {
    if (event is LoadProfile) {
      fetchUserProfile();
    } else if (event is UpdateFullName) {
      state = state.copyWith(fullName: event.fullName);
    } else if (event is UpdateGender) {
      state = state.copyWith(gender: event.gender);
    } else if (event is UpdatePhoneNumber) {
      state = state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is UpdateCaretaker) {
      state = state.copyWith(caretaker: event.caretaker);
    } else if (event is UpdateAddress) {
      state = state.copyWith(address: event.address);
    } else if (event is UpdateEmail) {
      state = state.copyWith(email: event.email);
    } else if (event is SubmitProfile) {
      updateProfile();
    }
  }

  Future<void> fetchUserProfile() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final token = await sessionManager.fetchAuthToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: "Authentication error: Token not available. Please log in again.",
        );
        return;
      }
      final userProfile = await repository.getUserProfile(token);
      state = state.copyWith(
        isLoading: false,
        fullName: userProfile.data.name,
        gender: userProfile.data.gender,
        phoneNumber: userProfile.data.phoneNo,
        caretaker: userProfile.data.caretaker,
        address: userProfile.data.address,
        email: userProfile.data.email,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load profile: ${e.toString()}",
      );
    }
  }

  Future<void> updateProfile() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final token = await sessionManager.fetchAuthToken();
      if (token == null || token.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: "Authentication error: Token not available. Please log in again.",
        );
        return;
      }
      await repository.updateUserProfile(
        token,
        UserEditProfileRequest(
          name: state.fullName,
          email: state.email,
          caretaker: state.caretaker,
          gender: state.gender,
          phoneNo: state.phoneNumber,
          address: state.address,
        ),
      );
      state = state.copyWith(isLoading: false, isSuccess: true, error: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}