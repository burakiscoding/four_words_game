import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class DbFailure extends Failure {
  const DbFailure({super.message = 'Something went wrong while accessing the data', super.statusCode});
}

class WordNotFoundFailure extends Failure {
  const WordNotFoundFailure({super.message = 'Word not found in db', super.statusCode});
}
