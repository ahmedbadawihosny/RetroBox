// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:retro_box/features/onboarding/data/data_source/onboarding_data.dart';
import 'package:retro_box/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:retro_box/features/onboarding/domain/repository/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingData onboardingData;

  OnboardingRepositoryImpl(
    this.onboardingData,
  );

  @override
  List<OnboardingEntity> viewOnboarding() {
    return onboardingData.viewOnboarding();
  }
}
