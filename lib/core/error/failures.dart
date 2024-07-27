import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  String get errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class ServerFailure extends Failures {
  ServerFailure({required this.errorMessage});
  @override
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class DatabaseFailure extends Failures {
  DatabaseFailure({required this.errorMessage});
  @override
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class UnexpectedFailure extends Failures {
  UnexpectedFailure({required this.errorMessage});
  @override
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class LocalServerFailure extends Failures {
  LocalServerFailure({required this.errorMessage});
  @override
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
