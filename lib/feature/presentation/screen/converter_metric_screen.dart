import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/number_formatter.dart';
import '../../domain/enums/length_unit.dart';
import '../../domain/extensions/length_unit_extension.dart';
import '../../domain/services/converter_metric_service.dart';

class ConverterMetricScreen extends StatefulWidget {
  const ConverterMetricScreen({super.key});

  @override
  State<ConverterMetricScreen> createState() => _ConverterMetricScreenState();
}

class _ConverterMetricScreenState extends State<ConverterMetricScreen>  {
  final _controller = TextEditingController();
  final _service = ConverterMetricService();

  LengthUnit from = LengthUnit.meter;
  LengthUnit to = LengthUnit.kilometer;

  double result = 0;

  void convert() {
    final value = double.tryParse(_controller.text) ?? 0;

    setState(() {
      result = _service.convertLength(
        value: value,
        from: from,
        to: to,
      );
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
      appBar: AppBar(
        title: const Text("Length Converter"),
        centerTitle: true,
      ),
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter value",
                ),
                onChanged: (_) => convert(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildDropdown(from, (val) {
                  HapticFeedback.selectionClick();
                  setState(() => from = val);
                  convert();
                })),

                const SizedBox(width: 12),

                GestureDetector(
                  onTap: swapUnits,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Icon(Icons.swap_vert),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(child: _buildDropdown(to, (val) {
                  HapticFeedback.selectionClick();
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
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Result",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "${NumberFormatter.format(result)} ${to.label}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Text(
              "${from.label} → ${to.label}",
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      LengthUnit value,
      Function(LengthUnit) onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: DropdownButton<LengthUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: LengthUnit.values.map((unit) {
          return DropdownMenuItem(
            value: unit,
            child: Text(
              unit.label,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}