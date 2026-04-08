import 'package:flutter/material.dart';

import '../widgets/app_theme.dart';
import '../widgets/soil_data_form.dart';

class DataManuallyScreen extends StatefulWidget {
  static const String routeName = "/manually";


  @override
  State<DataManuallyScreen> createState() => _DataManuallyScreenState();
}

class _DataManuallyScreenState extends State<DataManuallyScreen> {

  String selectedColor = "Select Color";

  List<String> soilColors = [
    "Yellow",
    "Brown",
    "Black"
  ];

  TextEditingController moistureController = TextEditingController();
  TextEditingController phController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: AppTheme.primary,
              size: 30),
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
              height: 50,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20),

                  Text(
                    "Enter Soil Data",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),

                  SizedBox(height: 30),

                  SoilDataForm(
                    onSubmit: (color, moisture, ph) {
                      print(color);
                      print(moisture);
                      print(ph);

                    },
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

