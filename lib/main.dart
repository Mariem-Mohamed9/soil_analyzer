import 'package:flutter/material.dart';
import 'package:soil_analyzer/screens/about_screen.dart';
import 'package:soil_analyzer/screens/contact_screen.dart';
import 'package:soil_analyzer/screens/data_manually_screen.dart';
import 'package:soil_analyzer/screens/home_screen.dart';
import 'package:soil_analyzer/screens/onboarding_screen.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';
import 'package:soil_analyzer/widgets/latest_analyses_section.dart';
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
      initialRoute: DataManuallyScreen.routeName,
      routes: {
        DataManuallyScreen.routeName : (context) => DataManuallyScreen(),
        ContactScreen.routeName : (context) => ContactScreen(),
        OnboardingScreen.routeName: (context) =>OnboardingScreen() ,
        HomeScreen.routeName : (context) => HomeScreen(),
        AboutScreen.routeName : (context)=> AboutScreen(),

      },


    );


  }
}


