import 'package:flutter/material.dart';
import 'package:fitness_app/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Track Your Goal",
      "description":
          "Don't worry if you have trouble determining your goals. We can help you determine your goals and track them.",
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Get Burn",
      "description":
          "Let's keep burning to achieve your goals. It hurts only temporarily. If you give up now, you will be in pain forever.",
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Eat Well",
      "description":
          "Let's start a healthy lifestyle with us. We can determine your diet every day. Healthy eating is fun.",
      "image": "assets/images/onboarding3.png"
    },
    {
      "title": "Improve Sleep Quality",
      "description":
          "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
      "image": "assets/images/onboarding4.png"
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        data["image"]!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["title"]!,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data["description"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
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
                          valueColor:
                              const AlwaysStoppedAnimation(Color(0xFFB266FF)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFB266FF),
                        ),
                        child: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white),
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
