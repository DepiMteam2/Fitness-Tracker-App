import 'package:fitness_app/src/auth/Auth.dart';
import 'package:fitness_app/src/constant/constant.dart';
import 'package:fitness_app/src/models/onboarding_model.dart';
import 'package:fitness_app/src/widgets/onboarding_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';  // إضافة مكتبة shared_preferences

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      title: "Track Your Goal",
      description: "Don't worry if you have trouble determining your goals. We can help you determine your goals and track them.",
      image: Constant.onBoardingImageOne,
    ),
    OnboardingModel(
      title: "Get Burn",
      description: "Let's keep burning to achieve your goals. It hurts only temporarily. If you give up now, you will be in pain forever.",
      image: Constant.onBoardingImageTwo,
    ),
    OnboardingModel(
      title: "Eat Well",
      description: "Let's start a healthy lifestyle with us. We can determine your diet every day. Healthy eating is fun.",
      image: Constant.onBoardingImageThree,
    ),
    OnboardingModel(
      title: "Improve Sleep Quality",
      description: "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
      image: Constant.onBoardingImageFour,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  // دالة للتحقق من حالة عرض الـ Onboarding
  _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isOnboardingShown = prefs.getBool('isOnboardingShown') ?? false;

    // إذا كانت القيمة true، نقوم بالانتقال مباشرة إلى شاشة الـ Auth
    if (isOnboardingShown) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Auth()),
      );
    }
  }

  void _nextPage() async {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // عند إتمام الـ Onboarding، نقوم بتخزين القيمة في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isOnboardingShown', true);

      // التنقل إلى شاشة الـ Auth
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Auth()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => OnboardingBuilder(data: onboardingData[index]),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: GestureDetector(
              onTap: _nextPage,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: (_currentPage + 1) / onboardingData.length,
                ),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 65,
                        height: 65,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation(Constant.secondColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constant.secondColor,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
