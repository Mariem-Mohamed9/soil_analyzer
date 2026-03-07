import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMenuVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isMenuVisible = !_isMenuVisible;
              });
            },
            child: SvgPicture.asset(
              "assets/icons/menu.svg",
              height: 60,
            ),
          ),
        ),
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

      body: Stack(
        children: [

          /// محتوى الصفحة
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined , size: 20,),
                  label: Text(
                    'Take Soil Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// الخلفية المموهة
          _isMenuVisible
              ? GestureDetector(
            onTap: () {
              setState(() {
                _isMenuVisible = false;
              });
            },
            child: Container(
              color: Colors.black54,
            ),
          )
              : SizedBox(),

          /// القائمة الجانبية
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _isMenuVisible ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Container(
              width: 250,
              color: Colors.white,
              child: Column(
                children: [
                  DrawerHeader(
                    child: Text(
                      "Menu",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "History",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        _isMenuVisible = false;
                      });
                    },
                  ),

                  ListTile(
                    title: Text(
                      "Contact us",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/contact");
                    },
                  ),

                  ListTile(
                    title: Text(
                      "About App",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}