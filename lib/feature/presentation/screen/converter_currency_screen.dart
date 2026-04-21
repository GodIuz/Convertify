import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/number_formatter.dart';
import '../../domain/enums/currency_unit.dart';
import '../../domain/extensions/currency_unit_extension.dart';
import '../../domain/services/converter_currency_service.dart';

class ConverterCurrencyScreen extends StatefulWidget {
  const ConverterCurrencyScreen({super.key});

  @override
  State<ConverterCurrencyScreen> createState() => _ConverterCurrencyScreenState();
}

class _ConverterCurrencyScreenState extends State<ConverterCurrencyScreen> {
  final _controller = TextEditingController();
  final _service = ConverterCurrencyService();

  CurrencyUnit from = CurrencyUnit.eur;
  CurrencyUnit to = CurrencyUnit.usd;

  double result = 0;
  bool isLoading = false;

  void convert() async {
    final value = double.tryParse(_controller.text) ?? 0;
    if (value == 0) return;

    setState(() => isLoading = true);

    try {
      final convertedValue = await _service.convertCurrency(
        amount: value,
        from: from,
        to: to,
      );

      if (mounted) {
        setState(() {
          result = convertedValue;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
        title: const Text("Currency Converter"),
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
                  hintText: "Enter amount",
                ),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: isLoading
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.swap_vert),
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
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade700,
                    Colors.teal.shade400,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Result",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${NumberFormatter.format(result)} ${to.code}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(CurrencyUnit value, Function(CurrencyUnit) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: DropdownButton<CurrencyUnit>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        menuMaxHeight: 350,
        items: CurrencyUnit.values.map((unit) {
          return DropdownMenuItem(
            value: unit,
            child: Text(unit.label),
          );
        }).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}