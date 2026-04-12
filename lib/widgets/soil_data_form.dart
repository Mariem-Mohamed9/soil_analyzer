import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

class SoilDataForm extends StatefulWidget {
  final Function(String color, String moisture, String ph) onSubmit;

  final bool showColor;

  const SoilDataForm({
    super.key,
    required this.onSubmit,
    this.showColor = true,
  });

  @override
  State<SoilDataForm> createState() => _SoilDataFormState();
}

class _SoilDataFormState extends State<SoilDataForm> {
  final _formKey = GlobalKey<FormState>();

  String selectedColor = "Select Color";

  List<String> soilColors = ["Yellow", "Brown", "Black"];

  TextEditingController moistureController = TextEditingController();
  TextEditingController phController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SizedBox(
          width: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///  Soil Color (يتعرض حسب الشرط)
              if (widget.showColor) ...[
                Text(
                  "Soil Color",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value:
                  selectedColor == "Select Color" ? null : selectedColor,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: soilColors.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Color",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (widget.showColor && value == null) {
                      return "Select a color";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
              ],

              /// Moisture
              Text("Moisture %",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),

              SizedBox(height: 8),

              TextFormField(
                controller: moistureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0 – 100",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  final num? m = num.tryParse(value);
                  if (m == null) return "Enter a valid number";
                  if (m < 0 || m > 100) return "Range: 0–100";
                  return null;
                },
              ),

              SizedBox(height: 20),

              /// pH
              Text("pH Value",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),

              SizedBox(height: 8),

              TextFormField(
                controller: phController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0 – 14",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  final num? p = num.tryParse(value);
                  if (p == null) return "Enter a valid number";
                  if (p < 0 || p > 14) return "Range: 0–14";
                  return null;
                },
              ),

              SizedBox(height: 30),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit(
                        selectedColor,
                        moistureController.text,
                        phController.text,
                      );
                    }
                  },
                  child: Text(
                    "Start Analysis",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}