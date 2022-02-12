import 'package:expense_bud/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/usecases/usecase.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/domain/repositories/user_preference_repository.dart';

class UpdateUserPreferenceUsecase implements Usecase<Unit, UserPreferenceEntity> {
  final IUserPreferenceRepository _userPreferenceRepository;
  UpdateUserPreferenceUsecase(this._userPreferenceRepository);
  
  @override
  Future<Either<Failure, Unit>> call(UserPreferenceEntity preference) {
    return _userPreferenceRepository.updateUserPreference(preference);
  }
}
