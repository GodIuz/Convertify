import 'package:convertify/feature/domain/enums/trigonometric_category.dart';
import 'package:convertify/feature/domain/enums/trigonometric_unit.dart';
import 'package:convertify/feature/domain/extensions/trigonometric_unit_extension.dart';
import 'package:convertify/feature/domain/services/trigonometry_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrigonometryScreen extends StatefulWidget {
  const TrigonometryScreen({super.key});

  @override
  State<TrigonometryScreen> createState() => _TrigonometryScreenState();
}

class _TrigonometryScreenState extends State<TrigonometryScreen> {
  final TrigonometryService _trigService = TrigonometryService();
  final TextEditingController _controller = TextEditingController(text: "0.00");

  Map<TrigonometricUnit, String> _calculatedResults = {};

  @override
  void initState() {
    super.initState();
    _calculate(); // Αρχικός υπολογισμός
  }

  void _calculate() {
    final text = _controller.text.trim().replaceAll(',', '.');
    final double? input = double.tryParse(text);

    setState(() {
      if (input == null) {
        _calculatedResults = {};
        return;
      }
      _calculatedResults = _trigService.calculateAll(input);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const trigCyan = Color(0xFF00E5FF);
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
          "Trigonometry Calculator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Value to Calculate (x)", style: TextStyle(color: Colors.white38, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A25),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: trigCyan.withValues(alpha: 0.1)),
                  ),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0.00",
                      hintStyle: TextStyle(color: Colors.white10),
                    ),
                    onChanged: (_) => _calculate(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _calculatedResults.isEmpty
                ? const Center(child: Text("Enter a valid number", style: TextStyle(color: Colors.white24)))
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                ...TrigonometricCategory.values.map((category) {
                  final functionsInCategory = TrigonometricUnit.values
                      .where((u) => u.category == category)
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          children: [
                            Icon(category.icon, color: trigCyan, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              category.label.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Grid για τα mini result cards
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: functionsInCategory.length,
                        itemBuilder: (context, index) {
                          final unit = functionsInCategory[index];
                          final value = _calculatedResults[unit] ?? "-";
                          return _MiniResultCard(
                            label: "${unit.label} (${unit.abbreviation})",
                            value: value,
                            accentColor: trigCyan,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    "CONVERTIFY v1.0",
                    style: TextStyle(color: Colors.white10, fontSize: 10, letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniResultCard extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _MiniResultCard({
    required this.label,
    required this.value,
    required this.accentColor,
  });
  @override
  Widget build(BuildContext context) {
    bool isError = value == "NaN" || value == "Undefined" || value == "∞";
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A25),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isError
              ? Colors.redAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                color: isError ? Colors.redAccent : accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}