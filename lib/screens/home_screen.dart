import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soil_analyzer/screens/soil_confirmation_screen.dart';
import 'package:soil_analyzer/widgets/app_theme.dart';
import 'package:soil_analyzer/widgets/latest_analysis_section.dart';
import '../models/history_item_model.dart';
import '../service/history_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMenuVisible = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SoilConfirmationScreen(image: imageFile),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => setState(() => _isMenuVisible = !_isMenuVisible),
            child: SvgPicture.asset("assets/icons/menu.svg", height: 60),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset("assets/images/logo_2.png", height: 60),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ✅ تم تعديل الـ Padding الخارجي لتقليل الـ Overflow
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                   SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon:  Icon(Icons.camera_alt_outlined, size: 30),
                    label:  Text(
                      'Take Soil Photo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize:  Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                   SizedBox(height: 20),
                   DividerWithText(text: "or"),
                   SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient:  LinearGradient(
                                  colors: [AppTheme.primary, Color(0xff4FA37B)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:  Icon(Icons.upload, color: Colors.white, size: 32),
                                ),
                              ),
                            ),
                             SizedBox(height: 15),
                             Text(
                              "Upload Soil Image",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
                   DividerWithText(text: "or"),
                   SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, "/manually"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primary,
                      minimumSize:  Size(double.infinity, 55),
                      side:  BorderSide(color: AppTheme.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child:  Text("Enter Soil Data Manually", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),

                   SizedBox(height: 50),

                  // ✅ العناوين ثابتة في الصفحة دائماً
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "Latest Analyses",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/history"),
                        child:  Text(
                          "See All >>",
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 20),

                  // ✅ الـ List فقط هي التي تظهر بعد تسجيل أول عملية
                  FutureBuilder<List<HistoryItem>>(
                    future: HistoryService().fetchHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return LatestAnalysisSection(historyList: snapshot.data!.take(5).toList());
                      }
                      // لو مفيش بيانات، بنعرض مساحة فاضية أو رسالة بسيطة
                      return  SizedBox(
                        height: 100,
                        child: Center(child: Text("History will appear here", style: TextStyle(color: Colors.grey))),
                      );
                    },
                  ),
                   SizedBox(height: 30), // مساحة أمان في النهاية
                ],
              ),
            ),
          ),

          if (_isMenuVisible)
            GestureDetector(
              onTap: () => setState(() => _isMenuVisible = false),
              child: Container(color: Colors.black54),
            ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isMenuVisible ? 0 : -250,
            top: 0, bottom: 0,
            child: _buildSideMenu(),
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(child: Text("Menu", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
          ),
          ListTile(leading: const Icon(Icons.history), title: const Text("History"), onTap: () => Navigator.pushNamed(context, "/history")),
          ListTile(leading: const Icon(Icons.contact_support), title: const Text("Contact us"), onTap: () {}),
          ListTile(leading: const Icon(Icons.info_outline), title: const Text("About App"), onTap: () {}),
        ],
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.blueGrey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        const Expanded(child: Divider(color: Colors.blueGrey)),
      ],
    );
  }
}