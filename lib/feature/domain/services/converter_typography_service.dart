

import 'package:convertify/feature/domain/enums/typography_unit.dart';

class ConverterTypographyService {
  static const Map<TypographyUnit, double> typoTo = {
    TypographyUnit.px: 1.0,
    TypographyUnit.ptTypo: 1.3333333333,
    TypographyUnit.picaTypo: 16.0,
    TypographyUnit.em: 16.0,
    TypographyUnit.remUnit: 16.0,
    TypographyUnit.mmTypo: 3.7795275591,
    TypographyUnit.cmTypo: 37.795275591,
    TypographyUnit.inTypo: 96.0,
    TypographyUnit.twip: 0.0666666667,
  };

  double convertTypography({
    required double value,
    required TypographyUnit from,
    required TypographyUnit to,
  }) {
    double pxValue = value * typoTo[from]!;
    return pxValue / typoTo[to]!;
  }
}