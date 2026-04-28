import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/force_unit.dart';
import 'package:convertify/feature/domain/extensions/force_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_force_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterForceScreen extends StatefulWidget {
  const ConverterForceScreen({super.key});

  @override
  State<ConverterForceScreen> createState() => _ConverterForceScreenState();
}

class _ConverterForceScreenState extends State<ConverterForceScreen> {
  final _controller = TextEditingController(text: "1");
  final _service = ConverterForceService();

  ForceUnit from = ForceUnit.kilonewton;
  ForceUnit to = ForceUnit.newton;
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
      result = _service.convertForce(value: value, from: from, to: to);
    });
  }

  @override
  Widget build(BuildContext context) {
    const forceBlue = Color(0xFF607D8B);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Force Converter", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputCard(forceBlue),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildDropdown(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, forceBlue)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.fitness_center, color: forceBlue, size: 28),
                ),
                Expanded(child: _buildDropdown(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, Colors.white10)),
              ],
            ),
            const SizedBox(height: 30),
            _buildResultCard(forceBlue),
          ],
        ),
      ),
    );
  }
  Widget _buildDropdown(ForceUnit value, Function(ForceUnit) onChanged, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ForceUnit>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A25),
          icon: Icon(Icons.keyboard_arrow_down, color: color),
          items: ForceUnit.values.map((unit) => DropdownMenuItem(
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
          BoxShadow(color: accentColor.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Text("OUTPUT POWER",
              style: TextStyle(color: accentColor,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              NumberFormatter.format(result),
              style: const TextStyle(fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            to.label.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14,
                color: Colors.white54,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  Widget _buildInputCard(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("VALUE TO CONVERT",
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
              suffixText: from.label.split('(').last.replaceAll(')', ''),
              suffixStyle: TextStyle(color: accentColor, fontSize: 16),
            ),
            onChanged: (_) => _convert(),
          ),
        ],
      ),
    );
  }
}