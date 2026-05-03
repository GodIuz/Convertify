import 'package:flutter/material.dart';
import '../enums/trigonometric_unit.dart';
import '../enums/trigonometric_category.dart';

extension TrigonometricUnitExtension on TrigonometricUnit {
  String get label {
    switch (this) {
      case TrigonometricUnit.sine: return 'Sine';
      case TrigonometricUnit.cosine: return 'Cosine';
      case TrigonometricUnit.tangent: return 'Tangent';
      case TrigonometricUnit.cotangent: return 'Cotangent';
      case TrigonometricUnit.secant: return 'Secant';
      case TrigonometricUnit.cosecant: return 'Cosecant';
      case TrigonometricUnit.arcsine: return 'Arcsine';
      case TrigonometricUnit.arccosine: return 'Arccosine';
      case TrigonometricUnit.arctangent: return 'Arctangent';
      case TrigonometricUnit.sinh: return 'Hyperbolic Sine';
      case TrigonometricUnit.cosh: return 'Hyperbolic Cosine';
      case TrigonometricUnit.tanh: return 'Hyperbolic Tangent';
      case TrigonometricUnit.coth: return 'Hyperbolic Cotangent';
      case TrigonometricUnit.sech: return 'Hyperbolic Secant';
      case TrigonometricUnit.csch: return 'Hyperbolic Cosecant';
      case TrigonometricUnit.asinh: return 'Inv. Hyperbolic Sine';
      case TrigonometricUnit.acosh: return 'Inv. Hyperbolic Cosine';
      case TrigonometricUnit.atanh: return 'Inv. Hyperbolic Tangent';
      case TrigonometricUnit.acoth: return 'Inv. Hyperbolic Cotangent';
      case TrigonometricUnit.asech: return 'Inv. Hyperbolic Secant';
      case TrigonometricUnit.acsch: return 'Inv. Hyperbolic Cosecant';
    }
  }

  String get abbreviation {
    switch (this) {
      case TrigonometricUnit.sine: return 'sin';
      case TrigonometricUnit.cosine: return 'cos';
      case TrigonometricUnit.tangent: return 'tan';
      case TrigonometricUnit.cotangent: return 'ctg';
      case TrigonometricUnit.secant: return 'sec';
      case TrigonometricUnit.cosecant: return 'csc';
      case TrigonometricUnit.arcsine: return 'asin';
      case TrigonometricUnit.arccosine: return 'acos';
      case TrigonometricUnit.arctangent: return 'atan';
      case TrigonometricUnit.sinh: return 'sinh';
      case TrigonometricUnit.cosh: return 'cosh';
      case TrigonometricUnit.tanh: return 'tanh';
      case TrigonometricUnit.coth: return 'coth';
      case TrigonometricUnit.sech: return 'sech';
      case TrigonometricUnit.csch: return 'csch';
      case TrigonometricUnit.asinh: return 'asinh';
      case TrigonometricUnit.acosh: return 'acosh';
      case TrigonometricUnit.atanh: return 'atanh';
      case TrigonometricUnit.acoth: return 'acoth';
      case TrigonometricUnit.asech: return 'asech';
      case TrigonometricUnit.acsch: return 'acsch';
    }
  }

  TrigonometricCategory get category {
    // index 0-5: Basic, 6-8: Inverse, 9-14: Hyperbolic, 15-20: Inverse Hyperbolic
    if (index <= 5) return TrigonometricCategory.basic;
    if (index <= 8) return TrigonometricCategory.inverse;
    if (index <= 14) return TrigonometricCategory.hyperbolic;
    return TrigonometricCategory.invHyper;
  }
}

// 2. Extension για τις κατηγορίες (TrigonometricCategory)
extension TrigonometricCategoryExtension on TrigonometricCategory {
  String get label {
    switch (this) {
      case TrigonometricCategory.basic: return 'Basic Functions';
      case TrigonometricCategory.inverse: return 'Inverse Functions';
      case TrigonometricCategory.hyperbolic: return 'Hyperbolic Functions';
      case TrigonometricCategory.invHyper: return 'Inv. Hyperbolic Functions';
    }
  }

  IconData get icon {
    switch (this) {
      case TrigonometricCategory.basic: return Icons.architecture;
      case TrigonometricCategory.inverse: return Icons.history;
      case TrigonometricCategory.hyperbolic: return Icons.auto_graph;
      case TrigonometricCategory.invHyper: return Icons.insights;
    }
  }
}