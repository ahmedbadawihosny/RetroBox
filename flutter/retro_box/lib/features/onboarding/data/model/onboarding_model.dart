import 'package:retro_box/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel(
      {required super.imagePath,
      required super.title,
      required super.description});

  factory OnboardingModel.fromJson(Map<String, dynamic> data) {
    return OnboardingModel(
      imagePath: data['imagePath'],
      title: data['title'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'imagePath': imagePath, 'title': title, 'description': description};
  }
}
