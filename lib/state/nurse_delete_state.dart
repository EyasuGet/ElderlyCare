class NurseDeleteState {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  NurseDeleteState({
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  NurseDeleteState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return NurseDeleteState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}