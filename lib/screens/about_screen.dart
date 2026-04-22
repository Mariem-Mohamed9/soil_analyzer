import 'package:flutter/material.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = "/about";


  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.primary , size: 50,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image.asset(
              "assets/images/logo_2.png",
              height: 60,
            ),
          ),
        ],
      ),

      body:
      SingleChildScrollView(
        child: Padding(padding:
        EdgeInsets.only( top: 20 , left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              "About AI Soil Analyzer",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary
                ),
              ),
              SizedBox(height: 10,),
              Text('AI Soil Analyzer is a smart agricultural application that helps users analyze soil easily using image analysis and simple data inputs. '
                  ' The app provides insights into soil type, condition,'
                  ' and suitable crops to support better planting decisions.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              ),
              SizedBox(height: 30,),
              Text('What the App Does',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    fontSize: 24
                  ),


              ),

              SizedBox(height: 10,),

              Text(
                 ' . Analyze soil type using images or manual data\n'
                  '. Provide pH and moisture insights\n'
                  '. Recommend suitable crops based on soil quality\n'
                 ' . Save analysis history for future reference\n',


                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),


              ),


            ],
          ),
        ),
      ),
    );

  }
}
