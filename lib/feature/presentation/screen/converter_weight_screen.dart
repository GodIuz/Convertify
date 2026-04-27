import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/weight_unit.dart';
import 'package:convertify/feature/domain/extensions/weight_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_weight_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterWeightScreen extends StatefulWidget {
  const ConverterWeightScreen({super.key});

  @override
  State<ConverterWeightScreen> createState() => _ConverterWeightScreenState();
}

class _ConverterWeightScreenState extends State<ConverterWeightScreen> {
  final _controller = TextEditingController();
  final _service = ConverterWeightService();


  WeightUnit from = WeightUnit.kilogram;
  WeightUnit to = WeightUnit.pound;
  double result = 0;

  void convert() {
    final value = double.tryParse(_controller.text) ?? 0;
    setState(() {
      result = _service.convertWeight(value: value, from: from, to: to);
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
      appBar: AppBar(title: const Text("Weight Converter"), centerTitle: true),
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
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Enter value"),
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
                gradient: const LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Result", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    "${NumberFormatter.format(result)} ${to.label}",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(WeightUnit value, Function(WeightUnit) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.surfaceContainer),
      child: DropdownButton<WeightUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: WeightUnit.values.map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}