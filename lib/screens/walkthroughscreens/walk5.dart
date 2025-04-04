import 'package:flutter/material.dart';

class walk5 extends StatefulWidget {
  final VoidCallback nextPage;
  const walk5({super.key, required this.nextPage});

  @override
  State<walk5> createState() => _WalkWeightState();
}

class _WalkWeightState extends State<walk5> {
  bool isKgSelected = true; // Default: Kg
  double weightValue = 60;  // Default weight in kg
  TextEditingController weightController = TextEditingController(text: "60");

  // Convert weight when unit changes
  void toggleUnit(String unit) {
    setState(() {
      if (unit == "Kg" && !isKgSelected) {
        // Convert from lbs to kg (1 lb = 0.453592 kg)
        weightValue = double.tryParse(weightController.text) ?? 132;
        weightValue *= 0.453592;
        weightController.text = weightValue.toStringAsFixed(0);
      } else if (unit == "Lbs" && isKgSelected) {
        // Convert from kg to lbs (1 kg = 2.20462 lbs)
        weightValue = double.tryParse(weightController.text) ?? 60;
        weightValue *= 2.20462;
        weightController.text = weightValue.toStringAsFixed(1);
      }
      isKgSelected = (unit == "Kg");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text("What’s Your Goal Weight?", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 150),

              // TextField for User Input
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          weightValue = double.tryParse(value) ?? weightValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(isKgSelected ? "Kg" : "Lbs", style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 20),

              // Toggle Buttons for Unit Selection
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _unitButton("Lbs", !isKgSelected),
                    _unitButton("Kg", isKgSelected),
                  ],
                ),
              ),
              SizedBox(height: 250),

              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
                onPressed: () => widget.nextPage(),
                child: Text("Continue", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitButton(String unit, bool isSelected) {
    return GestureDetector(
      onTap: () => toggleUnit(unit),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade50 : Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: unit == "Lbs" ? Radius.circular(30) : Radius.zero,
            right: unit == "Kg" ? Radius.circular(30) : Radius.zero,
          ),
        ),
        child: Text(
          unit,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.teal : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
