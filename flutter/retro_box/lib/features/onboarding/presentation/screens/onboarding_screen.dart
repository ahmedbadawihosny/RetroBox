// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/features/onboarding/data/data_source/onboarding_data.dart';
import 'package:retro_box/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:retro_box/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:retro_box/features/onboarding/domain/usecases/view_onboarding.dart';
import 'package:retro_box/features/onboarding/presentation/widgets/get_onboarding.dart';
import 'package:retro_box/features/onboarding/presentation/widgets/onboarding_btn.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  bool isLastPage = false;
  double progressValue = 0.3333;
  int pageNum = 0;

  // To hold the onboarding items
  List<OnboardingEntity> onboardingItems = [];

  @override
  void initState() {
    super.initState();
    _loadOnboardingData();
  }

  /// Fetch data from the data layer using the repository and use case
  void _loadOnboardingData() {
    final repository = OnboardingRepositoryImpl(OnboardingData());
    final viewOnboarding = ViewOnboarding(repository);

    setState(() {
      onboardingItems = viewOnboarding();
      progressValue = 1 / onboardingItems.length;
    });
  }

  void _setOnboardingState() async {
    /*
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    */
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Scaffold()));
  }

  void goToNextPage() => _controller.nextPage(
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

  void goToLastPage() => _controller.previousPage(
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: onboardingItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                contentPage(),
                const Spacer(),
                actionsPage(),
              ],
            ),
    );
  }

  SizedBox contentPage() {
    return SizedBox(
      height: 290,
      child: PageView.builder(
        onPageChanged: (index) => setState(() {
          isLastPage = onboardingItems.length - 1 == index;
          pageNum = index;
          progressValue = (index + 1) / onboardingItems.length;
        }),
        controller: _controller,
        itemCount: onboardingItems.length,
        itemBuilder: (context, index) {
          final item = onboardingItems[index];
          return GetOnboarding(
            image: item.imagePath,
            title: item.title,
            description: item.description,
          );
        },
      ),
    );
  }

  Row actionsPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 25,
        ),
        OnboardingBtn(
            btnTitle: 'Back', btnColor: AppColor.black, btnFun: goToLastPage),
        const Spacer(),
        SmoothPageIndicator(
          controller: _controller,
          count: onboardingItems.length,
          onDotClicked: (index) => _controller.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn),
          effect: const ExpandingDotsEffect(
              activeDotColor: AppColor.black,
              dotColor: AppColor.grey,
              dotWidth: 5,
              dotHeight: 5,
              spacing: 3),
        ),
        const Spacer(),
        isLastPage
            ? OnboardingBtn(
                btnTitle: 'Next',
                btnColor: AppColor.black,
                btnFun: _setOnboardingState)
            : OnboardingBtn(
                btnTitle: 'Next',
                btnColor: AppColor.black,
                btnFun: goToNextPage),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
