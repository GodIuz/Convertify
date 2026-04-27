import 'package:convertify/feature/domain/enums/time_unit.dart';
import 'package:convertify/feature/domain/extensions/time_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_time_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeConverterScreen extends StatefulWidget {
  const TimeConverterScreen({super.key});

  @override
  State<TimeConverterScreen> createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  final TextEditingController _controller = TextEditingController(text: "1");
  final ConverterTimeService _service = ConverterTimeService();

  TimeUnit _fromUnit = TimeUnit.year;
  TimeUnit _toUnit = TimeUnit.day;
  String _result = "";

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    final double? input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() => _result = "Invalid Input");
      return;
    }

    final double conversion = _service.convertTime(
      value: input,
      from: _fromUnit,
      to: _toUnit,
    );

    setState(() {
      if (conversion < 0.0001 || conversion > 1000000) {
        _result = conversion.toStringAsPrecision(4);
      } else {
        _result = conversion.toStringAsFixed(4).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
    _convert();
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Time Converter", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildUnitCard("From", _fromUnit, (val) {
              setState(() => _fromUnit = val!);
              _convert();
            }, isInput: true),

            const SizedBox(height: 16),

            IconButton(
              onPressed: _swapUnits,
              icon: const Icon(Icons.swap_vert_circle, color: Colors.purpleAccent, size: 40),
            ),

            const SizedBox(height: 16),

            _buildUnitCard("To", _toUnit, (val) {
              setState(() => _toUnit = val!);
              _convert();
            }, isInput: false),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(String label, TimeUnit unit, ValueChanged<TimeUnit?> onChanged, {required bool isInput}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isInput ? Colors.cyanAccent.withOpacity(0.3) : Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          Row(
            children: [
              Expanded(
                child: isInput
                    ? TextField(
                  controller: _controller,
                  onChanged: (_) => _convert(),
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: "0.0"),
                )
                    : Text(_result, style: const TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              DropdownButton<TimeUnit>(
                value: unit,
                dropdownColor: const Color(0xFF1A1A25),
                underline: const SizedBox(),
                items: TimeUnit.values.map((u) => DropdownMenuItem(
                  value: u,
                  child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
                )).toList(),
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}