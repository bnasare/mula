import 'package:dartz/dartz.dart';
import '../../domain/usecase/complete_onboarding.dart';
import '../../domain/usecase/is_onboarding_complete.dart';
import '../../domain/usecase/reset_onboarding.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';

class OnboardingBloc {
  final CompleteOnboarding completeOnboarding;
  final CheckOnboardingComplete checkOnboardingComplete;
  final ResetOnboarding resetOnboarding;
  OnboardingBloc({
    required this.completeOnboarding,
    required this.checkOnboardingComplete,
    required this.resetOnboarding,
  });

  Future<Either<Failure, Unit>> completeOnboardingChecks() async {
    return await completeOnboarding(NoParams());
  }

  Future<Either<Failure, bool>> checkIfOnboardingIsComplete() async {
    return await checkOnboardingComplete(NoParams());
  }

  Future<Either<Failure, Unit>> resetOnboardingState() async {
    return await resetOnboarding(NoParams());
  }
}
