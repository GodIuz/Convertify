import 'dart:math' as math;

import 'package:totalUnit/feature/domain/enums/trigonometric_unit.dart';

class TrigonometryService {
  static const double _epsilon = 1e-10;

  double _degreesToRadians(double degrees) => degrees * (math.pi / 180.0);
  double _radiansToDegrees(double radians) => radians * (180.0 / math.pi);

  String _formatNumber(double value) {
    if (value.isInfinite) return "∞";
    if (value.isNaN) return "Undefined";

    if (value.abs() > 1e10) {
      return value.toStringAsExponential(4);
    }

    String fixed = value.toStringAsFixed(4);
    if (fixed == "-0.0000" || fixed == "0.0000") return "0";
    return double.parse(fixed).toString();
  }

  String _formatAngleResult(double radians) {
    double degrees = _radiansToDegrees(radians);
    return "${_formatNumber(degrees)}°";
  }

  Map<TrigonometricUnit, String> calculateAll(double inputValue) {
    final Map<TrigonometricUnit, String> results = {};
    final double angleRadForBasic = _degreesToRadians(inputValue);
    final double s = math.sin(angleRadForBasic);
    final double c = math.cos(angleRadForBasic);
    results[TrigonometricUnit.sine] = _formatNumber(s);
    results[TrigonometricUnit.cosine] = _formatNumber(c);

    if (c.abs() < _epsilon) {
      results[TrigonometricUnit.tangent] = "∞";
      results[TrigonometricUnit.secant] = "∞";
    } else {
      results[TrigonometricUnit.tangent] = _formatNumber(math.tan(angleRadForBasic));
      results[TrigonometricUnit.secant] = _formatNumber(1.0 / c);
    }

    if (s.abs() < _epsilon) {
      results[TrigonometricUnit.cotangent] = "∞";
      results[TrigonometricUnit.cosecant] = "∞";
    } else {
      results[TrigonometricUnit.cosecant] = _formatNumber(1.0 / s);
      double tanV = math.tan(angleRadForBasic);
      if (tanV.abs() < _epsilon) {
        results[TrigonometricUnit.cotangent] = "∞";
      } else {
        results[TrigonometricUnit.cotangent] = _formatNumber(1.0 / tanV);
      }
    }

    if (inputValue < -1.0 || inputValue > 1.0) {
      results[TrigonometricUnit.arcsine] = "Undefined (|x|>1)";
      results[TrigonometricUnit.arccosine] = "Undefined (|x|>1)";
    } else {
      results[TrigonometricUnit.arcsine] = _formatAngleResult(math.asin(inputValue));
      results[TrigonometricUnit.arccosine] = _formatAngleResult(math.acos(inputValue));
    }
    results[TrigonometricUnit.arctangent] = _formatAngleResult(math.atan(inputValue));
    final double x = inputValue;
    final double ex = math.exp(x);
    final double emx = math.exp(-x);
    final double sh = (ex - emx) / 2.0;
    final double ch = (ex + emx) / 2.0;
    final double th = sh / ch;
    results[TrigonometricUnit.sinh] = _formatNumber(sh);
    results[TrigonometricUnit.cosh] = _formatNumber(ch);
    results[TrigonometricUnit.tanh] = _formatNumber(th);

    if (x.abs() < _epsilon) {
      results[TrigonometricUnit.coth] = "∞";
    } else {
      results[TrigonometricUnit.coth] = _formatNumber(1.0 / th);
    }

    results[TrigonometricUnit.sech] = _formatNumber(1.0 / ch);

    if (x.abs() < _epsilon) {
      results[TrigonometricUnit.csch] = "∞";
    } else {
      results[TrigonometricUnit.csch] = _formatNumber(1.0 / sh);
    }

    results[TrigonometricUnit.asinh] = _formatNumber(math.log(x + math.sqrt(x * x + 1)));

    if (x < 1.0) {
      results[TrigonometricUnit.acosh] = "Undefined (x<1)";
    } else {
      results[TrigonometricUnit.acosh] = _formatNumber(math.log(x + math.sqrt(x * x - 1)));
    }

    if (x <= -1.0 || x >= 1.0) {
      results[TrigonometricUnit.atanh] = "Undefined (|x|>=1)";
    } else {
      results[TrigonometricUnit.atanh] = _formatNumber(0.5 * math.log((1 + x) / (1 - x)));
    }

    if (x > -1.0 && x < 1.0) {
      results[TrigonometricUnit.acoth] = "Undefined (|x|<=1)";
    } else {
      results[TrigonometricUnit.acoth] = _formatNumber(0.5 * math.log((x + 1) / (x - 1)));
    }

    if (x <= 0.0 || x > 1.0) {
      results[TrigonometricUnit.asech] = "Undefined (x∉(0,1])";
    } else {
      results[TrigonometricUnit.asech] = _formatNumber(math.log((1 + math.sqrt(1 - x * x)) / x));
    }

    if (x.abs() < _epsilon) {
      results[TrigonometricUnit.acsch] = "∞";
    } else {
      double valForLog;
      if (x > 0) {
        valForLog = (1 + math.sqrt(1 + x * x)) / x;
      } else {
        valForLog = (1 - math.sqrt(1 + x * x)) / x;
      }
      results[TrigonometricUnit.acsch] = _formatNumber(math.log(valForLog));
    }

    return results;
  }
}