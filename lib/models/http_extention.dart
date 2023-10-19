class httpException implements Exception {
  final String exception;
  httpException(this.exception);

  @override
  String toString() {
    return exception;
  }
}
