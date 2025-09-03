abstract class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException({required this.message, this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class DbException extends AppException {
  DbException({super.message = 'Something went wrong while accessing the data'}) : super(prefix: 'Database Error: ');
}

class WordNotFoundException extends AppException {
  WordNotFoundException({super.message = 'Word not found in db'}) : super(prefix: 'Word Not Found Error: ');
}
