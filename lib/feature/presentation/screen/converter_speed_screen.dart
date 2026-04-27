import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/speed_unit.dart';
import 'package:convertify/feature/domain/extensions/speed_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_speed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterSpeedScreen extends StatefulWidget {
  const ConverterSpeedScreen({super.key});

  @override
  State<ConverterSpeedScreen> createState() => _ConverterSpeedScreenState();
}

class _ConverterSpeedScreenState extends State<ConverterSpeedScreen> {
  final _controller = TextEditingController();
  final _service = ConverterSpeedService();

  SpeedUnit from = SpeedUnit.kmh;
  SpeedUnit to = SpeedUnit.ms;
  double result = 0;

  void convert() {
    final value = double.tryParse(_controller.text) ?? 0;
    setState(() {
      result = _service.convertSpeed(value: value, from: from, to: to);
    });
  }

  void swapUnits() {
    HapticFeedback.lightImpact();
    setState(() {
      final temp = from;
      from = to;
      to = temp;
    });
    convert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Speed Converter"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 28),
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Enter speed"),
                onChanged: (_) => convert(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildDropdown(from, (val) {
                  setState(() => from = val);
                  convert();
                })),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: swapUnits,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer),
                    child: const Icon(Icons.swap_vert),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdown(to, (val) {
                  setState(() => to = val);
                  convert();
                })),
              ],
            ),

            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [Colors.blue.shade700, Colors.indigo.shade400]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Result", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    NumberFormatter.format(result),
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    to.label, // ✅ Εδώ χρησιμοποιείται το extension
                    style: const TextStyle(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(SpeedUnit value, Function(SpeedUnit) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.surfaceContainer),
      child: DropdownButton<SpeedUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: SpeedUnit.values.map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}