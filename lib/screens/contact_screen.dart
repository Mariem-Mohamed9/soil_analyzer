import 'package:flutter/material.dart';

import '../widgets/app_theme.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = "/contact";
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
        EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Have a question or need help?",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary
                ),
              ),
              SizedBox(height: 10,),
              Text('We’re here to support you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 26,),
              Text('Email : mariammohamedsabet@gmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),


              ),



              SizedBox(height: 60,),



              Center(
                child: Text(
                  'We usually respond within 24 hours',


                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    color: AppTheme.primary

                  ),
                  textAlign: TextAlign.center,


                ),

              ),


            ],
          ),
        ),
      ),
    );
  }
}
