import 'package:dartz/dartz.dart';

extension EitherGetRight<L, R> on Either<L, R> {
  R getRight() {
    return fold(
      (left) => throw UnimplementedError('Cannot get Right from Left'),
      (right) => right,
    );
  }
  R? getOrNull() {
    return fold(
      (left) => null,
      (right) => right,
    );
  }
}