import 'package:flutter/material.dart';
import 'package:soil_analyzer/screens/page_view_items.dart';
import '../widgets/app_theme.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

   OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _handleButton(String buttonText) {
    if (buttonText == "Next" || buttonText == "Explore New") {
      if (_currentPage < onboardingList.length - 1) {
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else if (buttonText == "Back") {
      if (_currentPage > 0) {
        _controller.previousPage(
          duration:  Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else if (buttonText == "Start Analyzing" || buttonText == "Finish") {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return PageViewItem(
                  item: onboardingList[index],
                  onButtonPressed: _handleButton,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingList.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}