import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/failure/failure.dart';

abstract class UsecaseOfStream<R, P> {
  Stream<Either<Failure, R>> call(P arg);
}

abstract class NoArgsUsecaseOfStream<R> {
  Stream<Either<Failure, R>> call();
}

abstract class UsecaseOfFuture<R, P> {
  Future<Either<Failure, R>> call(P arg);
}

abstract class NoArgsUsecaseOfFuture<R> {
  Future<Either<Failure, R>> call();
}
