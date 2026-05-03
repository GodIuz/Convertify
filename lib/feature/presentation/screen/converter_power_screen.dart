import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/power_unit.dart';
import 'package:convertify/feature/domain/services/converter_power_service.dart';
import 'package:convertify/feature/domain/services/power_unit_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterPowerScreen extends StatefulWidget {
  const ConverterPowerScreen({super.key});

  @override
  State<ConverterPowerScreen> createState() => _ConverterPowerScreenState();
}

class _ConverterPowerScreenState extends State<ConverterPowerScreen> {
  final _controller = TextEditingController(text: "1.00");
  final _service = ConverterPowerService();

  PowerUnit from = PowerUnit.kilowatt;
  PowerUnit to = PowerUnit.hp_metric;
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
      result = _service.convertPower(value: value, from: from, to: to);
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = from;
      from = to;
      to = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    const powerOrange = Color(0xFFFF6D00);

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
          "Power Converter",
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
                border: Border.all(color: powerOrange.withOpacity(0.1)),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                decoration: const InputDecoration(border: InputBorder.none, hintText: "0.00"),
                onChanged: (_) => _convert(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(child: _buildDropdownColumn("From", from, (val) {
                  setState(() => from = val!);
                  _convert();
                }, powerOrange)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: _swapUnits,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: powerOrange.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.swap_horiz, color: powerOrange, size: 24),
                    ),
                  ),
                ),

                Expanded(child: _buildDropdownColumn("To", to, (val) {
                  setState(() => to = val!);
                  _convert();
                }, Colors.amber)),
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
                  BoxShadow(color: powerOrange.withOpacity(0.05), blurRadius: 20, spreadRadius: 1),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Text(
                    "OUTPUT POWER",
                    style: TextStyle(color: powerOrange.withOpacity(0.6), fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      NumberFormatter.format(result),
                      style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold, color: Colors.white),
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
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownColumn(String title, PowerUnit value, ValueChanged<PowerUnit?> onChanged, Color accentColor) {
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
            border: Border.all(color: accentColor.withOpacity(0.1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PowerUnit>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A25),
              icon: Icon(Icons.keyboard_arrow_down, color: accentColor, size: 20),
              items: PowerUnit.values.map((u) => DropdownMenuItem(
                value: u,
                child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis),
              )).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}