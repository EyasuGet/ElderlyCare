import 'package:elderly_care/data/remote/request/nurse_profile_request.dart';
import 'package:elderly_care/data/remote/response/nurse_profile_response.dart';

import '../api/nurse_profile_api_service.dart';

class NurseProfileRepository {
  final NurseProfileApiService api;
  NurseProfileRepository(this.api);

  Future<NurseProfileResponse> getNurseProfile(String token) {
    return api.getNurseProfile(token);
  }

  Future<NurseProfileResponse> updateNurseProfile(String token, NurseProfileRequest request) {
    return api.updateNurseProfile(token, request);
  }
}