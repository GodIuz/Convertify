import 'package:convertify/feature/domain/enums/volume_unit.dart';

class ConverterVolumeService {
  static const Map<VolumeUnit, double> volumeTo ={
   VolumeUnit.liter: 0.001,
   VolumeUnit.milliliter: 1e-6,
   VolumeUnit.centiliter: 0.00001,
   VolumeUnit.deciliter: 0.0001,
   VolumeUnit.cubic_meter: 1.0,
   VolumeUnit.cubic_cm: 1e-6,
   VolumeUnit.cubic_mm: 1e-9,
   VolumeUnit.cubic_inch: 1.6387064e-5,
   VolumeUnit.cubic_foot: 0.0283168466,
   VolumeUnit.cubic_yard: 0.764554858,
   VolumeUnit.gallon_us: 0.0037854118,
   VolumeUnit.gallon_uk: 0.00454609,
   VolumeUnit.quart_us: 0.0009463529,
   VolumeUnit.pint_us: 0.0004731765,
   VolumeUnit.pint_uk: 0.0005682613,
   VolumeUnit.cup_us: 0.0002365882,
   VolumeUnit.cup_metric: 0.00025,
   VolumeUnit.fluid_oz_us: 2.95735e-5,
   VolumeUnit.fluid_oz_uk: 2.84131e-5,
   VolumeUnit.tablespoon_us: 1.478676e-5,
   VolumeUnit.tablespoon_uk: 1.77582e-5,
   VolumeUnit.teaspoon_us: 4.928922e-6,
   VolumeUnit.teaspoon_uk: 5.91939e-6,
   VolumeUnit.barrel_oil: 0.158987295,
   VolumeUnit.barrel_us: 0.119240471,
   VolumeUnit.hogshead: 0.238481,
   VolumeUnit.drop: 0.00000005
  };

  double convertVolume({
    required double value,
    required VolumeUnit from,
    required VolumeUnit to,
  }) {
    return (value * volumeTo[from]!) / volumeTo[to]!;
  }
}