import 'package:boilerplate_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams([this.isOnline = false]);

  final bool isOnline;

  @override
  List<Object?> get props => [isOnline];
}
