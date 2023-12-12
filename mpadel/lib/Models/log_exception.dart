class LogException implements Exception {
  final String message;
  final dynamic error;

  LogException(this.message, [this.error]);

  @override
  String toString() => 'LogException: $message\n$error';
}
