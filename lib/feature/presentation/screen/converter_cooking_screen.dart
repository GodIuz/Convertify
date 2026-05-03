import 'package:convertify/feature/domain/enums/cooking_unit.dart';
import 'package:convertify/feature/domain/extensions/cooking_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_cooking_service.dart';
import 'package:flutter/material.dart';

class ConverterCookingScreen extends StatefulWidget {
  const ConverterCookingScreen({super.key});

  @override
  State<ConverterCookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<ConverterCookingScreen> {
  final _controller = TextEditingController(text: "0.00");
  CookingUnit _fromUnit = CookingUnit.cupUsCook;
  CookingUnit _toUnit = CookingUnit.mlCook;
  String _resultValue = "0";

  // Λογική υπολογισμού βάσει των συντελεστών που ορίσαμε στο Service
  void _calculate() {
    double val = double.tryParse(_controller.text) ?? 0;
    double fromFactor = ConverterCookingService.cookingTo[_fromUnit] ?? 1.0;
    double toFactor = ConverterCookingService.cookingTo[_toUnit] ?? 1.0;

    // Μετατροπή: (Τιμή * Συντελεστής Από) / Συντελεστής Προς
    double res = (val * fromFactor) / toFactor;

    setState(() {
      if (res == 0) {
        _resultValue = "0";
      } else if (res.abs() < 0.01) {
        _resultValue = res.toStringAsFixed(4);
      } else {
        _resultValue = double.parse(res.toStringAsFixed(3)).toString();
      }
    });
  }

  // Λειτουργία εναλλαγής μονάδων (Swap)
  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10), // Σκούρο background όπως η φωτό 1
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Cooking Converter",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quantity", style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 8),

            // Μεγάλο Input Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (_) => _calculate(),
              ),
            ),

            const SizedBox(height: 25),

            // Σειρά με τα Dropdowns (From - Swap - To)
            Row(
              children: [
                Expanded(child: _buildDropdownColumn("From", _fromUnit, (val) {
                  setState(() => _fromUnit = val!);
                  _calculate();
                })),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                  child: GestureDetector(
                    onTap: _swapUnits,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF132B31), // Σκούρο κυανό για το εικονίδιο swap
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.swap_horiz, color: Colors.cyanAccent, size: 24),
                    ),
                  ),
                ),

                Expanded(child: _buildDropdownColumn("To", _toUnit, (val) {
                  setState(() => _toUnit = val!);
                  _calculate();
                })),
              ],
            ),

            const SizedBox(height: 40),

            // Η Μεγάλη Κάρτα Αποτελέσματος
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.1), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    _resultValue,
                    style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 48,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _toUnit.label,
                    style: const TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget για τα dropdowns
  Widget _buildDropdownColumn(String title, CookingUnit value, ValueChanged<CookingUnit?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CookingUnit>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A25),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white24),
              items: CookingUnit.values.map((u) => DropdownMenuItem(
                value: u,
                child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 13)),
              )).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}