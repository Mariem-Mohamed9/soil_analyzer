import 'package:flutter/material.dart';
import 'package:soil_analyzer/screens/home_screen.dart';
import 'package:soil_analyzer/screens/onboarding_screen.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';
void main() {
  runApp(SoilAnalyzer());
}
class SoilAnalyzer extends StatefulWidget {


  @override
  State<SoilAnalyzer> createState() => _SoilAnalyzerState();
}

class _SoilAnalyzerState extends State<SoilAnalyzer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (context) =>OnboardingScreen() ,
        HomeScreen.routeName : (context) => HomeScreen(),

      },


    );


  }
}


