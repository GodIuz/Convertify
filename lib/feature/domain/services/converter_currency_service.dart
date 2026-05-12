import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:totalUnit/feature/domain/enums/currency_unit.dart';

class ConverterCurrencyService {
  static const String _apiKey = "acecfc556779dc60b6992973";
  static const String _baseUrl = "https://v6.exchangerate-api.com/v6/$_apiKey/pair";

  Future<double> convertCurrency({
    required double amount,
    required CurrencyUnit from,
    required CurrencyUnit to,
  }) async {
    if (from == to) return amount;
    if (amount == 0) return 0;

      try {
        final url = Uri.parse('$_baseUrl/${CurrencyUnit.cad}/${CurrencyUnit.cad}/$amount');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return (data['conversion_result'] as num).toDouble();
        }
        return 0.0;
      } catch (e) {
        return 0.0;
      }
    }
  }