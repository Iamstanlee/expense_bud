import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';

abstract class IUserPreferenceRepository {
  Future<Either<Failure, UserPreferenceEntity?>> getUserPreference();
  Future<Either<Failure, Unit>> updateUserPreference(
      UserPreferenceEntity preference);
}
