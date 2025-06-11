import 'package:elderly_care/utils/auth_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api/signup_api_service.dart';
import '../../data/api/login_api_service.dart';
import '../../data/api/schedule_api_service.dart';
import '../../data/api/user_profile_api_service.dart';
import '../../data/api/care_schedule_api_service.dart';
import '../../data/api/nurse_api_service.dart';
import '../../data/api/view_detail_api_service.dart';
import '../../data/api/nurse_delete_api_service.dart';
import '../../data/api/nurse_profile_api_service.dart';
import '../../data/repository/signup_repository.dart';
import '../../data/repository/login_repository.dart';
import '../../data/repository/schedule_repository.dart';
import '../../data/repository/user_profile_repository.dart';
import '../../data/repository/care_schedule_repository.dart';
import '../../data/repository/nurse_repository.dart';
import '../../data/repository/view_detail_repository.dart';
import '../../data/repository/nurse_delete_repository.dart';
import '../../data/repository/nurse_profile_repository.dart';

// You can set baseUrl here or provide it via a provider
const baseUrl = "http://localhost:8000";

final sessionManagerProvider = Provider((ref) => SessionManager());

final signUpApiServiceProvider = Provider((ref) => SignUpApiService(baseUrl));
final loginApiServiceProvider = Provider((ref) => LoginApiService(baseUrl));
final scheduleApiServiceProvider = Provider((ref) => ScheduleApiService(baseUrl));
final userProfileApiServiceProvider = Provider((ref) => UserProfileApiService(baseUrl));
final nurseApiServiceProvider = Provider((ref) => NurseApiService(baseUrl));
final viewDetailApiServiceProvider = Provider((ref) => ViewDetailApiService(baseUrl));
final nurseDeleteApiServiceProvider = Provider((ref) => NurseDeleteApiService(baseUrl));
final nurseProfileApiServiceProvider = Provider((ref) => NurseProfileApiService(baseUrl));
final careScheduleApiServiceProvider = Provider((ref) => CareScheduleApiService(baseUrl));

final signUpRepositoryProvider = Provider(
    (ref) => SignUpRepository(ref.watch(signUpApiServiceProvider)));
final loginRepositoryProvider = Provider(
    (ref) => LoginRepository(ref.watch(loginApiServiceProvider)));
final scheduleRepositoryProvider = Provider(
    (ref) => ScheduleRepository(ref.watch(scheduleApiServiceProvider)));
final userProfileRepositoryProvider = Provider(
    (ref) => UserProfileRepository(ref.watch(userProfileApiServiceProvider)));
final nurseRepositoryProvider = Provider(
    (ref) => NurseRepository(ref.watch(nurseApiServiceProvider)));
final viewDetailRepositoryProvider = Provider(
    (ref) => ViewDetailRepository(ref.watch(viewDetailApiServiceProvider)));
final nurseDeleteRepositoryProvider = Provider(
    (ref) => NurseDeleteRepository(ref.watch(nurseDeleteApiServiceProvider)));
final nurseProfileRepositoryProvider = Provider(
    (ref) => NurseProfileRepository(ref.watch(nurseProfileApiServiceProvider)));
final careScheduleRepositoryProvider = Provider(
    (ref) => CareScheduleRepository(ref.watch(careScheduleApiServiceProvider)));