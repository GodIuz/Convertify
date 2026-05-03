import 'package:convertify/feature/domain/enums/radiation_unit.dart';
import 'package:convertify/feature/domain/extensions/radiation_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_radiation_service.dart';
import 'package:flutter/material.dart';

class RadiationScreen extends StatefulWidget {
  const RadiationScreen({super.key});

  @override
  State<RadiationScreen> createState() => _RadiationScreenState();
}

class _RadiationScreenState extends State<RadiationScreen> {
  final _controller = TextEditingController(text: "0.0");
  final _service = ConverterRadiationService();

  RadiationUnit fromUnit = RadiationUnit.millisievert;
  RadiationUnit toUnit = RadiationUnit.sievert;
  String result = "0";

  void _convert() {
    final value = double.tryParse(_controller.text) ?? 0;
    final conversions = _service.convert(value, fromUnit);
    setState(() {
      result = conversions[toUnit] ?? "0";
    });
  }

  void _swap() {
    setState(() {
      final temp = fromUnit;
      fromUnit = toUnit;
      toUnit = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Colors.purpleAccent; // Όπως στο screenshot

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Radiation Converter", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 1. Input Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (_) => _convert(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Dropdowns & Swap
            Row(
              children: [
                Expanded(child: _buildDropdown(fromUnit, (val) {
                  setState(() => fromUnit = val!);
                  _convert();
                }, accentColor)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: _swap,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: accentColor, shape: BoxShape.circle),
                      child: const Icon(Icons.swap_horiz, color: Colors.white, size: 20),
                    ),
                  ),
                ),

                Expanded(child: _buildDropdown(toUnit, (val) {
                  setState(() => toUnit = val!);
                  _convert();
                }, accentColor)),
              ],
            ),
            const SizedBox(height: 30),

            // 3. Large Result Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  const Text("Result", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  const SizedBox(height: 10),
                  Text(result, style: const TextStyle(color: Colors.cyanAccent, fontSize: 48, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(toUnit.label.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(RadiationUnit value, ValueChanged<RadiationUnit?> onChanged, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A25), borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RadiationUnit>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A25),
          icon: Icon(Icons.keyboard_arrow_down, color: color),
          items: RadiationUnit.values.map((u) => DropdownMenuItem(
            value: u,
            child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 13)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}