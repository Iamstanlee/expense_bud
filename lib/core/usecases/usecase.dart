import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failure/failure.dart';

abstract class Usecase<R, P> {
  Future<Either<Failure, R>> call(P arg);
}

abstract class NoArgsUsecase<R> {
  Future<Either<Failure, R>> call();
}
