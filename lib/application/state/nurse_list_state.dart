import '../../data/remote/response/nurse_list_response.dart';

class NurseListState {
  final List<NurseListResponse> elderList;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  NurseListState({
    this.elderList = const [],
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  NurseListState copyWith({
    List<NurseListResponse>? elderList,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) => NurseListState(
        elderList: elderList ?? this.elderList,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        isSuccess: isSuccess ?? this.isSuccess,
      );
}