import 'package:totalUnit/feature/domain/enums/typography_unit.dart';

extension TypographyUnitExtension on TypographyUnit{
  String get label{
    switch(this){
      case TypographyUnit.px:
        return "Pixel (px)";
      case TypographyUnit.ptTypo:
        return "Point (pt)";
      case TypographyUnit.picaTypo:
        return "Pica (pc)";
      case TypographyUnit.em:
        return "Em (em)";
      case TypographyUnit.remUnit:
        return "Rem (rem)";
      case TypographyUnit.mmTypo:
        return "Millimeter (mm)";
      case TypographyUnit.cmTypo:
        return "Centimeter (cm)";
      case TypographyUnit.inTypo:
        return "Inch (in)";
      case TypographyUnit.twip:
        return "Twip (twip)";
    }
  }
}