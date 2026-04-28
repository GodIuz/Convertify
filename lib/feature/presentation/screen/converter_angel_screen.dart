import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/angle_unit.dart';
import 'package:convertify/feature/domain/extensions/angle_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_angle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterAngleScreen extends StatefulWidget {
  const ConverterAngleScreen({super.key});

  @override
  State<ConverterAngleScreen> createState() => _ConverterAngleScreenState();
}

class _ConverterAngleScreenState extends State<ConverterAngleScreen> {
  final _controller = TextEditingController(text: "1");
  final _service = ConverterAngleService();

  AngleUnit from = AngleUnit.degree;
  AngleUnit to = AngleUnit.radian;
  double result = 0;

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    final text = _controller.text.trim().replaceAll(',', '.');

    final value = double.tryParse(text) ?? 0;
    setState(() {
      result = _service.convertAngle(value: value, from: from, to: to);
    });
  }

  @override
  Widget build(BuildContext context) {
    const angleCyan = Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Angle Converter", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputCard(angleCyan),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildDropdown(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, angleCyan)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      final temp = from; from = to; to = temp;
                    });
                    _convert();
                  },
                  icon: const Icon(Icons.sync_alt, color: angleCyan),
                ),
                Expanded(child: _buildDropdown(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, Colors.white24)),
              ],
            ),
            const SizedBox(height: 30),
            _buildResultCard(angleCyan),
          ],
        ),
      ),
    );
  }
// 1. Το κουτάκι της εισαγωγής (Input)
  Widget _buildInputCard(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1A1A25),
        // Χρησιμοποιούμε .withValues αντί για withOpacity για το 2026!
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("VALUE",
              style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "0.0",
              hintStyle: const TextStyle(color: Colors.white10),
              suffixIcon: Icon(Icons.architecture, color: accentColor.withValues(alpha: 0.5)),
            ),
            onChanged: (_) => _convert(),
          ),
        ],
      ),
    );
  }

  // 2. Το Dropdown
  Widget _buildDropdown(AngleUnit value, Function(AngleUnit) onChanged, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AngleUnit>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A25),
          icon: Icon(Icons.expand_more, color: color),
          items: AngleUnit.values.map((unit) => DropdownMenuItem(
            value: unit,
            child: Text(unit.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }

  // 3. Η κάρτα του αποτελέσματος
  Widget _buildResultCard(Color accentColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A25), Color(0xFF0D0D15)],
        ),
        boxShadow: [
          BoxShadow(color: accentColor.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 1),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text("CONVERTED ANGLE",
              style: TextStyle(color: accentColor, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              NumberFormatter.format(result),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            to.label.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}