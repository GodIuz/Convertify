import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/frequency_unit.dart';
import 'package:convertify/feature/domain/extensions/frequency_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_frequency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterFrequencyScreen extends StatefulWidget {
  const ConverterFrequencyScreen({super.key});

  @override
  State<ConverterFrequencyScreen> createState() => _ConverterFrequencyScreenState();
}

class _ConverterFrequencyScreenState extends State<ConverterFrequencyScreen> {
  final _controller = TextEditingController(text: "1");
  final _service = ConverterFrequencyService();

  FrequencyUnit from = FrequencyUnit.megahertz;
  FrequencyUnit to = FrequencyUnit.hertz;
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
      result = _service.convertFrequency(
          value: value,
          from: from,
          to: to
      );
    });
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
    const freqPurple = Color(0xFF6200EA);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Frequency Converter",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputCard(freqPurple),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: _buildDropdown(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, freqPurple)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: _swapUnits,
                    icon: const Icon(Icons.swap_horiz, color: freqPurple, size: 32),
                  ),
                ),

                Expanded(child: _buildDropdown(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, Colors.white24)),
              ],
            ),

            const SizedBox(height: 35),
            _buildResultCard(freqPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("FREQUENCY VALUE",
              style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            style: const TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "0.0",
              hintStyle: const TextStyle(color: Colors.white10),
              suffixIcon: Icon(Icons.waves, color: accentColor.withValues(alpha: 0.6)),
            ),
            onChanged: (_) => _convert(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(FrequencyUnit value, Function(FrequencyUnit) onChanged, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<FrequencyUnit>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A25),
          items: FrequencyUnit.values.map((u) => DropdownMenuItem(
            value: u,
            child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }

  Widget _buildResultCard(Color accentColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A25), const Color(0xFF050505)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: accentColor.withValues(alpha: 0.1), blurRadius: 40, spreadRadius: 2)
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text("CONVERTED FREQUENCY",
              style: TextStyle(color: accentColor, fontSize: 12, letterSpacing: 2.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              NumberFormatter.format(result),
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            to.label.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.white38, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}