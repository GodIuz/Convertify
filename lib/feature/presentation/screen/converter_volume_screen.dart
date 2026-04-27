import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/volume_unit.dart';
import 'package:convertify/feature/domain/extensions/volume_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_volume_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterVolumeScreen extends StatefulWidget {
const ConverterVolumeScreen({super.key});

@override
State<ConverterVolumeScreen> createState() => _ConverterVolumeScreenState();
}

class _ConverterVolumeScreenState extends State<ConverterVolumeScreen> {
  final _controller = TextEditingController(text: "1");
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
    });
    _convert();
  }

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF0077FF);
    final accentCyan = const Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Volume Converter",
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
                border: Border.all(color: primaryBlue.withOpacity(0.3)),
              ),
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.0",
                  hintStyle: const TextStyle(color: Colors.white24),
                  suffixText: from.label.split('(').last.replaceAll(')', ''),
                  suffixStyle: TextStyle(color: primaryBlue, fontSize: 16),
                ),
                onChanged: (_) => _convert(),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: _buildUnitSelector(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, primaryBlue)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: _swapUnits,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryBlue.withOpacity(0.15),
                        border: Border.all(color: primaryBlue.withOpacity(0.5)),
                      ),
                      child: Icon(Icons.swap_horiz, color: accentCyan, size: 28),
                    ),
                  ),
                ),
                Expanded(child: _buildUnitSelector(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, accentCyan)),
              ],
            ),
            const SizedBox(height: 35),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF1A1A25), const Color(0xFF0D0D15)],
                ),
                boxShadow: [
                  BoxShadow(color: primaryBlue.withOpacity(0.15), blurRadius: 25, spreadRadius: 2),
                ],
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Text("CONVERTED VOLUME",
                      style: TextStyle(color: primaryBlue.withOpacity(0.7), fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      NumberFormatter.format(result),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    to.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white54, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSelector(VolumeUnit value, Function(VolumeUnit) onChanged, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VolumeUnit>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.expand_more, color: accentColor, size: 20),
          dropdownColor: const Color(0xFF1A1A25),
          borderRadius: BorderRadius.circular(20),
          items: VolumeUnit.values.map((unit) => DropdownMenuItem(
            value: unit,
            child: Text(unit.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }
}