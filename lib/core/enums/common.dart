enum LoadingStatus {
  initial,
  loading,
  success,
  error,
}

extension LoadingStatusX on LoadingStatus {
  bool get isInitial => this == LoadingStatus.initial;

  bool get isSuccess => this == LoadingStatus.success;

  bool get isError => this == LoadingStatus.error;

  bool get isLoading => this == LoadingStatus.loading;
}
