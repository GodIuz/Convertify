import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/area_unit.dart';
import 'package:convertify/feature/domain/extensions/area_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_area_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterAreaScreen  extends StatefulWidget{
  const ConverterAreaScreen({super.key});
  State<ConverterAreaScreen> createState() => _ConverterAreaConverterState();
}

class _ConverterAreaConverterState extends State<ConverterAreaScreen>{
  final _controller = TextEditingController();
  final _service = ConverterAreaService();

  AreaUnit from = AreaUnit.sq_meter;
  AreaUnit to = AreaUnit.sq_km;
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Area Converter"), centerTitle: true),
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
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Enter size"),
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
                gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF00BCD4)]),
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
                    to.label,
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

  Widget _buildDropdown(AreaUnit value, Function(AreaUnit) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.surfaceContainer),
      child: DropdownButton<AreaUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: AreaUnit.values.map((unit) => DropdownMenuItem(value: unit, child: Text(unit.label))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }

  void convert() {
    final value = double.tryParse(_controller.text) ?? 0;
    setState(() {
      result = _service.convertArea(value: value, from: from, to: to);
    });
  }

  void swapUnits() {
    HapticFeedback.lightImpact();
    setState(() {
      final area  = from;
      from = to;
      to = area;
    });
    convert();
  }
}