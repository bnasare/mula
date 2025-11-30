import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../repository/onboarding_repository.dart';

class ResetOnboarding implements UseCase<Unit, NoParams> {
  final OnboardingRepository repository;

  ResetOnboarding(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.resetOnboarding();
  }
}
