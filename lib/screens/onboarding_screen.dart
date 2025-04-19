import 'package:fitness_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold();
  }
  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introkey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final pagedecoration = PageDecoration(
      imageFlex: 2,
      titleTextStyle: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF7B78FF),
      ),
      bodyTextStyle: const TextStyle(
        fontSize: 13.0,
        color: Colors.black54,
      ),
      bodyPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      pageColor: const Color(0xFFf3f4f6),
      
    );
    return IntroductionScreen(
      key: introkey,
      globalBackgroundColor: const Color(0xFFf3f4f6),

      pages: [
        PageViewModel(
          title: "Track Your Goals",
          body:
              "Don’t worry if you have trouble determining your goals, We can help you determine your goals and track your goals.",
          image: Image.asset('assets/images/onboarding1.png'),
          decoration: pagedecoration,
        ),
        PageViewModel(
          title: "Get Burned Calories",
          body: "Let's keep burning, to achieve your goals, it hurts only temporarily, if you give up now you will be in pain forever.",
          image: Image.asset('assets/images/onboarding2.png'),
          decoration: pagedecoration,
        ),
        PageViewModel(
          title: "Eat Well, Live Well",
          body: "Let’s start a healthy lifestyle with us, we can determine your diet every day, healthy eating is fun.",
          image: Image.asset('assets/images/onboarding3.png'),
          decoration: pagedecoration,
        ),
        PageViewModel(
          title: "Improve Sleep Quality",
          body: "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning.",
          image: Image.asset('assets/images/onboarding4.png'),
          decoration: pagedecoration,
        ),
      ],
      next: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF7B78FF), Color(0xFFDE58E3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      showDoneButton: true,
      done: Text(
        "Let's Go!",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: const Color(0xFF7B78FF),
        ),
      ),
      onDone: () {
        // Handle the action when the user presses the done button
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
    );
  }
}
