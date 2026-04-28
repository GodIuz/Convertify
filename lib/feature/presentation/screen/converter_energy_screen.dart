import 'package:convertify/core/utils/number_formatter.dart';
import 'package:convertify/feature/domain/enums/energy_unit.dart';
import 'package:convertify/feature/domain/extensions/energy_unit_extension.dart';
import 'package:convertify/feature/domain/services/converter_energy_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterEnergyScreen extends StatefulWidget {
  const ConverterEnergyScreen({super.key});

  @override
  State<ConverterEnergyScreen> createState() => _ConverterEnergyScreenState();
}

class _ConverterEnergyScreenState extends State<ConverterEnergyScreen> {
  final _controller = TextEditingController(text: "1");
  final _service = ConverterEnergyService();

  EnergyUnit from = EnergyUnit.joule;
  EnergyUnit to = EnergyUnit.kilocalorie;
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
      result = _service.convertEnergy(value: value, from: from, to: to);
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
    const primaryYellow = Color(0xFFFFD600);
    const accentAmber = Color(0xFFFFAB00);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Energy Converter",
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF1A1A25),
                border: Border.all(color: primaryYellow.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("INPUT VALUE", style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  TextField(
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                    style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0.0",
                      hintStyle: const TextStyle(color: Colors.white10),
                      suffixIcon: Icon(Icons.bolt, color: primaryYellow.withOpacity(0.5)),
                    ),
                    onChanged: (_) => _convert(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildUnitSelector(from, (val) {
                  setState(() => from = val);
                  _convert();
                }, primaryYellow)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    onPressed: _swapUnits,
                    icon: const Icon(Icons.sync_alt, color: primaryYellow, size: 30),
                  ),
                ),

                Expanded(child: _buildUnitSelector(to, (val) {
                  setState(() => to = val);
                  _convert();
                }, accentAmber)),
              ],
            ),

            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [const Color(0xFF1A1A25), const Color(0xFF050505)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: primaryYellow.withOpacity(0.05), blurRadius: 30, spreadRadius: 5)
                ],
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  const Text("EQUIVALENT ENERGY",
                      style: TextStyle(color: primaryYellow, fontSize: 12, letterSpacing: 3, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
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
                    style: const TextStyle(fontSize: 14, color: Colors.white38, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSelector(EnergyUnit value, Function(EnergyUnit) onChanged, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A1A25),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EnergyUnit>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A25),
          items: EnergyUnit.values.map((u) => DropdownMenuItem(
            value: u,
            child: Text(u.label, style: const TextStyle(color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis)),
          )).toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }
}

