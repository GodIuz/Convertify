import 'package:totalUnit/core/utils/number_formatter.dart';
import 'package:totalUnit/feature/domain/enums/volume_unit.dart';
import 'package:totalUnit/feature/domain/extensions/volume_unit_extension.dart';
import 'package:totalUnit/feature/domain/services/converter_volume_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterVolumeScreen extends StatefulWidget {
  const ConverterVolumeScreen({super.key});

  @override
  State<ConverterVolumeScreen> createState() => _ConverterVolumeScreenState();
}

class _ConverterVolumeScreenState extends State<ConverterVolumeScreen> {
  final _controller = TextEditingController(text: "1.00");
  final _service = ConverterVolumeService();

  VolumeUnit from = VolumeUnit.liter;
  VolumeUnit to = VolumeUnit.milliliter;
  double result = 0;

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    final text = _controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) {
      setState(() => result = 0);
      return;
    }
    final value = double.tryParse(text) ?? 0;
    setState(() {
      result = _service.convertVolume(value: value, from: from, to: to);
    });
  }

  void _swapUnits() {
    HapticFeedback.mediumImpact();
    setState(() {
      final temp = from;
      from = to;
      to = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    const volumeBlue = Color(0xFF0077FF);
    const volumeCyan = Color(0xFF00E5FF);
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Volume Converter",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Value to Convert", style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: volumeBlue.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.00",
                  hintStyle: TextStyle(color: Colors.white10),
                ),
                onChanged: (_) => _convert(),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: _buildDropdownColumn("From", from, (val) {
                  setState(() => from = val!);
                  _convert();
                }, volumeBlue)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: _swapUnits,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: volumeBlue.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: volumeBlue.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(Icons.swap_horiz, color: volumeCyan, size: 24),
                    ),
                  ),
                ),
                Expanded(child: _buildDropdownColumn("To", to, (val) {
                  setState(() => to = val!);
                  _convert();
                }, volumeCyan)),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 45),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A25),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: volumeBlue.withValues(alpha: 0.05), blurRadius: 20, spreadRadius: 1),
                ],
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Column(
                children: [
                  const Text(
                    "RESULT",
                    style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      NumberFormatter.format(result),
                      style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold, color: volumeCyan),
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
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                "TOTAL UNIT v1.0",
                style: TextStyle(color: Colors.white10, fontSize: 10, letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownColumn(String title, VolumeUnit value, ValueChanged<VolumeUnit?> onChanged, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accentColor.withValues(alpha: 0.1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<VolumeUnit>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A25),
              icon: Icon(Icons.keyboard_arrow_down, color: accentColor, size: 20),
              items: VolumeUnit.values.map((u) => DropdownMenuItem(
                value: u,
                child: Text(u.label,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}