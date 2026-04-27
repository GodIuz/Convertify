import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/pressure_unit.dart';
import 'package:convertify/feature/domain/extensions/pressure_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_pressure_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterPressureScreen extends StatefulWidget {
  const ConverterPressureScreen({super.key});

  @override
  State<ConverterPressureScreen> createState() => _ConverterPressureScreenState();
}

class _ConverterPressureScreenState extends State<ConverterPressureScreen> {
  final _controller = TextEditingController();
  final _service = ConverterPressureService();

  PressureUnit from = PressureUnit.bar;
  PressureUnit to = PressureUnit.pascal;
  double result = 0;

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    final text = _controller.text.trim().replaceAll(',', '.');

    if (text.isEmpty) {
      setState(() {
        result = 0;
      });
      return;
    }

    final value = double.tryParse(text);

    if (value != null) {
      setState(() {
        result = _service.convertPressure(value: value, from: from, to: to);
      });
    } else {
      setState(() {
        result = 0;
      });
    }
  }

  void _swapUnits() {
    HapticFeedback.mediumImpact();
    setState(() {
      final temp = from;
      from = to;
      to = temp;
    });
    _convert();
  }

  @override
  Widget build(BuildContext context) {
    final primaryNeon = const Color(0xFF00E5FF);
    final secondaryNeon = const Color(0xFFD500F9);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Pressure Converter",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF1A1A25),
                border: Border.all(color: primaryNeon.withOpacity(0.2)),
              ),
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.0",
                  hintStyle: TextStyle(color: Colors.white24),
                  suffixText: from.label.split('(').last.replaceAll(')', ''),
                  suffixStyle: TextStyle(color: primaryNeon, fontSize: 16),
                ),
                onChanged: (_) => _convert(),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildUnitSelector(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, primaryNeon)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: _swapUnits,
                    icon: Icon(Icons.swap_horizontal_circle, color: secondaryNeon, size: 45),
                  ),
                ),

                Expanded(child: _buildUnitSelector(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, secondaryNeon)),
              ],
            ),

            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF1A1A25), const Color(0xFF0B0B10)],
                ),
                boxShadow: [
                  BoxShadow(color: primaryNeon.withOpacity(0.1), blurRadius: 20, spreadRadius: 1),
                ],
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  const Text("Result",
                      style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      NumberFormatter.format(result),
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: primaryNeon),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    to.label.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Text("CONVERTIFY v1.0",
                style: TextStyle(color: Colors.white10, fontSize: 10, letterSpacing: 3)),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSelector(PressureUnit value, Function(PressureUnit) onChanged, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PressureUnit>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: accentColor),
          dropdownColor: const Color(0xFF1A1A25),
          items: PressureUnit.values.map((unit) => DropdownMenuItem(
            value: unit,
            child: Text(unit.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }
}