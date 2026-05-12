import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totalUnit/feature/domain/enums/flow_rate_unit.dart';
import 'package:totalUnit/feature/domain/extensions/flow_rate_unit_extensiom.dart';
import 'package:totalUnit/feature/domain/services/converter_flow_rate_service.dart';

class FlowRateConverterScreen extends StatefulWidget {
  const FlowRateConverterScreen({super.key});

  @override
  State<FlowRateConverterScreen> createState() => _FlowRateConverterScreenState();
}

class _FlowRateConverterScreenState extends State<FlowRateConverterScreen> {
  final _controller = TextEditingController(text: "1.00");
  final ConverterFlowRateService _service = ConverterFlowRateService();

  FlowRateUnit _fromUnit = FlowRateUnit.ls;
  FlowRateUnit _toUnit = FlowRateUnit.m3h;
  String _resultValue = '0';

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    HapticFeedback.lightImpact();
    final text = _controller.text.trim().replaceAll(',', '.');
    final double value = double.tryParse(text) ?? 0;
    final double converted = _service.convert(value, _fromUnit, _toUnit);
    setState(() {
      _resultValue = _service.formatResult(converted);
    });
  }

  void _swapUnits() {
    HapticFeedback.lightImpact();
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    const flowGreen = Color(0xFF00FF88);

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
          "Flow Rate Converter",
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
                border: Border.all(color: flowGreen.withValues(alpha: 0.1)),
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
                Expanded(child: _buildDropdownColumn("From", _fromUnit, (val) {
                  setState(() => _fromUnit = val!);
                  _convert();
                }, flowGreen)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: _swapUnits,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: flowGreen.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.swap_horiz, color: flowGreen, size: 24),
                    ),
                  ),
                ),
                Expanded(child: _buildDropdownColumn("To", _toUnit, (val) {
                  setState(() => _toUnit = val!);
                  _convert();
                }, Colors.white24)),
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
                  BoxShadow(color: flowGreen.withValues(alpha: 0.05), blurRadius: 20, spreadRadius: 1),
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
                      _resultValue,
                      style: const TextStyle(
                        color: flowGreen,
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _toUnit.label.toUpperCase(),
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

  Widget _buildDropdownColumn(String title, FlowRateUnit value, ValueChanged<FlowRateUnit?> onChanged, Color accentColor) {
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
            child: DropdownButton<FlowRateUnit>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A25),
              icon: Icon(Icons.keyboard_arrow_down, color: accentColor, size: 20),
              items: FlowRateUnit.values.map((u) {
                return DropdownMenuItem(
                  value: u,
                  child: Text(
                    u.label,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}