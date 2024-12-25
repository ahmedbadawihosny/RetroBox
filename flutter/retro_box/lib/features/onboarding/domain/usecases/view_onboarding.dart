import 'package:retro_box/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:retro_box/features/onboarding/domain/repository/onboarding_repository.dart';

class ViewOnboarding {
  final OnboardingRepository onboarding;
  ViewOnboarding(this.onboarding);

  List<OnboardingEntity> call() {
    return onboarding.viewOnboarding();
  }
}
