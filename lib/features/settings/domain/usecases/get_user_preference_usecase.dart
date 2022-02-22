import 'package:expense_bud/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/usecases/usecase.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/domain/repositories/user_preference_repository.dart';

class GetUserPreferenceUsecase implements NoArgsUsecaseOfFuture<UserPreferenceEntity?> {
  final IUserPreferenceRepository _userPreferenceRepository;
  GetUserPreferenceUsecase(this._userPreferenceRepository);
  @override
  Future<Either<Failure, UserPreferenceEntity?>> call() {
    return _userPreferenceRepository.getUserPreference();
  }
}
