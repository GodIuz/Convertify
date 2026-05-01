import 'package:convertify/feature/domain/enums/illuminance_unit.dart';
import 'package:convertify/feature/domain/extensions/illuminance_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_illuminance_service.dart';
import 'package:flutter/material.dart';

class ConverterIlluminanceScreen extends StatefulWidget {
  const ConverterIlluminanceScreen({super.key});

  @override
  State<ConverterIlluminanceScreen> createState() => _IlluminanceConverterScreenState();
}

class _IlluminanceConverterScreenState extends State<ConverterIlluminanceScreen> {
  final ConverterIlluminanceService _service = ConverterIlluminanceService();

  double _inputValue = 0;
  IlluminanceUnit _fromUnit = IlluminanceUnit.lux;
  IlluminanceUnit _toUnit = IlluminanceUnit.footcandle;
  String _result = '0';

  void _calculate() {
    final double converted = _service.convert(_inputValue, _fromUnit, _toUnit);
    setState(() {
      _result = _service.formatResult(converted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Illuminance Converter",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Light Intensity", style: TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 12),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1A1A25),
                hintText: "0.00",
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
                ),
              ),
              onChanged: (value) {
                _inputValue = double.tryParse(value) ?? 0;
                _calculate();
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildUnitPicker("From", _fromUnit, (val) {
                  setState(() => _fromUnit = val!);
                  _calculate();
                })),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.swap_horiz, color: Colors.cyanAccent, size: 20),
                  ),
                ),
                Expanded(child: _buildUnitPicker("To", _toUnit, (val) {
                  setState(() => _toUnit = val!);
                  _calculate();
                })),
              ],
            ),
            const SizedBox(height: 48),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A25),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            _result,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.cyanAccent, fontSize: 42, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(_toUnit.label, style: const TextStyle(color: Colors.white54, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildUnitPicker(String label, IlluminanceUnit selected, Function(IlluminanceUnit?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<IlluminanceUnit>(
              value: selected,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A25),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white30),
              items: IlluminanceUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}