import 'package:expense_bud/features/settings/data/datasources/user_preference_local_datasource.dart';
import 'package:expense_bud/features/settings/data/user_preference_mapper.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_bud/features/settings/domain/repositories/user_preference_repository.dart';

class UserPreferenceRepository implements IUserPreferenceRepository {
  final IUserPreferenceLocalDataSource _localDataSource;
  UserPreferenceRepository(this._localDataSource);

  @override
  Future<Either<Failure, UserPreferenceEntity?>> getUserPreference() async {
    try {
      final pref = await _localDataSource.getUserPreference();

      return Right(pref?.toEntity());
    } catch (e) {
      return Left(CacheGetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserPreference(
    UserPreferenceEntity pref,
  ) async {
    try {
      await _localDataSource.updateUserPreference(pref.toModel());
      return const Right(unit);
    } catch (e) {
      return Left(CachePutFailure());
    }
  }
}
