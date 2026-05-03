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
  final _service = ConverterRadiationService();
  final _controller = TextEditingController();
  RadiationUnit _selectedUnit = RadiationUnit.sievert;
  Map<RadiationUnit, String> _results = {};

  void _calculate() {
    if (_controller.text.isEmpty) {
      setState(() => _results = {});
      return;
    }
    double? val = double.tryParse(_controller.text);
    if (val != null) {
      setState(() => _results = _service.convert(val, _selectedUnit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Radiation Converter", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "Enter Value",
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                      border: InputBorder.none,
                      hintText: "0.0",
                      hintStyle: TextStyle(color: Colors.white10),
                    ),
                    onChanged: (_) => _calculate(),
                  ),
                  const Divider(color: Colors.white10, height: 20),
                  DropdownButton<RadiationUnit>(
                    value: _selectedUnit,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A1A25),
                    underline: const SizedBox(),
                    icon: const Icon(Icons.unfold_more, color: Colors.cyanAccent),
                    items: RadiationUnit.values.map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit.label, style: const TextStyle(color: Colors.cyanAccent)),
                    )).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedUnit = val);
                        _calculate();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: _results.isEmpty
                ? const Center(child: Text("Waiting for input...", style: TextStyle(color: Colors.white24)))
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: RadiationUnit.values.map((unit) {
                final resultValue = _results[unit] ?? "";
                if (resultValue == "N/A") return const SizedBox.shrink();

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A25),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: unit == _selectedUnit ? Colors.cyanAccent.withOpacity(0.3) : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(unit.label, style: const TextStyle(color: Colors.white70)),
                      Flexible(
                        child: Text(
                          resultValue,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}