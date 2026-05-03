import 'package:convertify/feature/domain/enums/trigonometric_category.dart';
import 'package:convertify/feature/domain/enums/trigonometric_unit.dart';
import 'package:convertify/feature/domain/extensions/trigonometric_unit_extension.dart';
import 'package:convertify/feature/domain/services/trigonometry_service.dart';
import 'package:flutter/material.dart';

class TrigonometryScreen extends StatefulWidget {
  const TrigonometryScreen({super.key});

  @override
  State<TrigonometryScreen> createState() => _TrigonometryScreenState();
}

class _TrigonometryScreenState extends State<TrigonometryScreen> {
  final TrigonometryService _trigService = TrigonometryService();
  final TextEditingController _controller = TextEditingController();

  Map<TrigonometricUnit, String> _calculatedResults = {};
  String? _errorText;

  void _onCalculatePressed() {
    setState(() {
      _errorText = null;
      double? input = double.tryParse(_controller.text);

      if (input == null) {
        _errorText = "Enter a valid number";
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
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        title: const Text("Trigonometry Calculator",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: const Color(0xFF1A1A25),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        decoration: InputDecoration(
                          labelText: 'Enter value x',
                          labelStyle: const TextStyle(color: Colors.white54),
                          hintText: 'e.g. 45 or 0.5',
                          hintStyle: const TextStyle(color: Colors.white24),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
                          errorText: _errorText,
                        ),
                        onSubmitted: (_) => _onCalculatePressed(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _onCalculatePressed,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Icon(Icons.calculate_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: _calculatedResults.isEmpty
                ? const Center(child: Text("Waiting for input...",
                style: TextStyle(color: Colors.white24)))
                : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: TrigonometricCategory.values.map((category) {
                  final functionsInCategory = TrigonometricUnit.values
                      .where((u) => u.category == category)
                      .toList();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      leading: Icon(category.icon, color: Colors.cyanAccent),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white54,
                      title: Text(
                        category.label,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.5,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            children: functionsInCategory.map((unit) {
                              final resultValue = _calculatedResults[unit] ?? "-";
                              return _ResultCard(
                                title: "${unit.label} (${unit.abbreviation})",
                                value: resultValue,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String value;

  const _ResultCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    bool isError = value == "NaN" || value == "Undefined" || value == "∞";

    return Container(
      decoration: BoxDecoration(
        color: isError ? Colors.red.withOpacity(0.1) : Colors.cyanAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isError ? Colors.redAccent.withOpacity(0.3) : Colors.cyanAccent.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isError ? Colors.redAccent : Colors.cyanAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}