import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/number_formatter.dart';
import '../../domain/enums/temperature_unit.dart';
import '../../domain/extensions/temperature_unit_extension.dart';

class ConverterTemperatureScreen extends StatefulWidget {
  const ConverterTemperatureScreen({super.key});

  @override
  State<ConverterTemperatureScreen> createState() => _ConverterTemperatureScreenState();

  double convertTemperature({
    required double value,
    required TemperatureUnit from,
    required TemperatureUnit to,
  }) {
    if (from == to) return value;

    double celsius;
    switch (from) {
      case TemperatureUnit.celsius:
        celsius = value;
        break;
      case TemperatureUnit.fahrenheit:
        celsius = (value - 32) * 5 / 9;
        break;
      case TemperatureUnit.kelvin:
        celsius = value - 273.15;
        break;
      case TemperatureUnit.rankine:
        celsius = (value - 491.67) * 5 / 9;
        break;
      case TemperatureUnit.reaumur:
        celsius = value * 1.25;
        break;
    }

    switch (to) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
      case TemperatureUnit.kelvin:
        return celsius + 273.15;
      case TemperatureUnit.rankine:
        return (celsius + 273.15) * 9 / 5;
      case TemperatureUnit.reaumur:
        return celsius * 0.8;
    }
  }
}

class _ConverterTemperatureScreenState extends State<ConverterTemperatureScreen> {
  final _controller = TextEditingController();
  final _service = ConverterTemperatureScreen();

  TemperatureUnit from = TemperatureUnit.celsius;
  TemperatureUnit to = TemperatureUnit.fahrenheit;
  double result = 0;

  void convert() {
    final value = double.tryParse(_controller.text) ?? 0;
    setState(() {
      result = _service.convertTemperature(value: value, from: from, to: to);
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
      appBar: AppBar(title: const Text("Temperature Converter"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Container (Σύμφωνα με το στυλ σου)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                style: const TextStyle(fontSize: 28),
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Enter value"),
                onChanged: (_) => convert(),
              ),
            ),
            const SizedBox(height: 24),
            // Selectors + Swap
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
            // Result Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]),
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

  Widget _buildDropdown(TemperatureUnit value, Function(TemperatureUnit) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.surfaceContainer),
      child: DropdownButton<TemperatureUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: TemperatureUnit.values.map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}