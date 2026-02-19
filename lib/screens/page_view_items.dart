import 'package:flutter/material.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';
import 'onboarding_data.dart';

class PageViewItem extends StatelessWidget {
  final OnboardingModel item;
  final Function(String) onButtonPressed;

  const PageViewItem({
    super.key,
    required this.item,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.image,
            height: 220,
          ),
           SizedBox(height: 20),


          Text(
            item.title,
            style:  TextStyle(
              color: AppTheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,

          ),

           SizedBox(height: 12),

          Text(
            item.description,
            style:  TextStyle(fontSize: 20,
            fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),

           SizedBox(height: 32),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              minimumSize:  Size(300 , 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => onButtonPressed(item.buttonText),
            child: Text(
              item.buttonText,
              style:  TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

           SizedBox(height: 24),

          if (item.showSkip)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primary,
                elevation: 0,
                minimumSize: Size( 300 , 50),
                side: BorderSide(
                  color: AppTheme.primary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => onButtonPressed("Finish"),
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
