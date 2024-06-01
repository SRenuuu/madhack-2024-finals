class ForceLogoutException implements Exception {
  final String message;

  ForceLogoutException(this.message);

  @override
  String toString() {
    return 'ForceLogoutException: $message';
  }
}
