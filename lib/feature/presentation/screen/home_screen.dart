import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:convertify/feature/presentation/screen/converter_document_format_screen.dart';
import 'converter_electric_screen.dart';
import 'converter_image_screen.dart';
import 'converter_angel_screen.dart';
import 'converter_area_screen.dart';
import 'converter_cooking_screen.dart';
import 'converter_density_screen.dart';
import 'converter_digital_screen.dart';
import 'converter_energy_screen.dart';
import 'converter_flow_rate_screen.dart';
import 'converter_force_screen.dart';
import 'converter_frequency_screen.dart';
import 'converter_fuel_economy_screen.dart';
import 'converter_illuminance_screen.dart';
import 'converter_power_screen.dart';
import 'converter_pressure_screen.dart';
import 'converter_speed_screen.dart';
import 'converter_time_screen.dart';
import 'converter_torque_screen.dart';
import 'converter_volume_screen.dart';
import 'trigonometry_screen.dart';
import 'converter_radiation_screen.dart';
import 'converter_metric_screen.dart';
import 'converter_temperature_screen.dart';
import 'package:flutter/material.dart';
import 'converter_currency_screen.dart';
import 'converter_weight_screen.dart';
import 'converter_numeral_screen.dart';
import 'converter_typography_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Convertify",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: const [
            _CategoryCard(
              title: "Length",
              icon: Icons.straighten,
              color: Colors.cyan,
              screen: ConverterMetricScreen()
            ),
            _CategoryCard(
              title: "Weight",
              icon: Icons.monitor_weight,
              color: Colors.purple,
              screen: ConverterWeightScreen(),
            ),
            _CategoryCard(
              title: "Temperature",
              icon: Icons.thermostat,
              color: Colors.orange,
              screen: ConverterTemperatureScreen(),
            ),
            _CategoryCard(
              title: "Currency",
              icon: Icons.attach_money,
              color: Colors.green,
              requiresInternet: true,
              screen: ConverterCurrencyScreen()
            ),
            _CategoryCard(
                title: "Speed",
                icon: Icons.speed,
                color: Colors.tealAccent,
               screen: ConverterSpeedScreen(),
            ),
            _CategoryCard(
                title: "Storage",
                icon: Icons.storage,
                color: Colors.red,
                screen: ConverterDigitalScreen(),
            ),
            _CategoryCard(
                title: "Time",
                icon: Icons.timer,
                color: Colors.brown,
                screen: TimeConverterScreen(),
            ),
            _CategoryCard(
                title: "Area",
                icon: Icons.crop_square,
                color: Colors.lime,
                screen: ConverterAreaScreen(),
            ),
            _CategoryCard(
                title: "Volume",
                icon: Icons.local_drink,
                color: Colors.blueGrey,
                screen: ConverterVolumeScreen(),
            ),
            _CategoryCard(
                title: "Pressure",
                icon: Icons.compress,
                color: Colors.pinkAccent,
                screen: ConverterPressureScreen()
            ),
            _CategoryCard(
                title: "Energy",
                icon: Icons.energy_savings_leaf,
                color: Colors.lime,
                screen: ConverterEnergyScreen(),
            ),
            _CategoryCard(
                title: "Power",
                icon: Icons.power,
                color: Colors.blue,
                screen: ConverterPowerScreen(),
            ),
            _CategoryCard(
                title: "Angle",
                icon: Icons.change_history,
                color: Colors.green,
                screen: ConverterAngleScreen(),
            ),
            _CategoryCard(
                title: "Fuel Economy",
                icon: Icons.local_gas_station,
                color: Colors.indigo,
                screen: ConverterFuelScreen(),
            ),
            _CategoryCard(
                title: "Frequency",
                icon: Icons.graphic_eq,
                color: Colors.pink,
                screen: ConverterFrequencyScreen(),
            ),
            _CategoryCard(
                title: "Force",
                icon: Icons.sports_martial_arts,
                color: Colors.yellowAccent,
                screen: ConverterForceScreen()
            ),
            _CategoryCard(
                title: "Torque",
                icon: Icons.settings,
                color: Colors.amberAccent,
                screen: ConverterTorqueScreen(),
            ),
            _CategoryCard(
                title: "Density",
                icon: Icons.layers, 
                color: Colors.deepOrange,
                screen: DensityConverterScreen(),
            ),
            _CategoryCard(
                title: "Flow Rate",
                icon: Icons.water_drop,
                color: Colors.tealAccent,
                screen: FlowRateConverterScreen(),
            ),
            _CategoryCard(
                title: "Illuminance",
                icon: Icons.wb_sunny,
                color: Colors.red,
                screen: ConverterIlluminanceScreen()
            ),
            _CategoryCard(
                title: "Radiation",
                icon: Icons.radar,
                color: Colors.amber,
                screen: RadiationScreen(),
            ),
            _CategoryCard(
                title: "Cooking",
                icon: Icons.restaurant,
                color: Colors.purpleAccent,
                screen: ConverterCookingScreen(),
            ),
            _CategoryCard(
                title: "Trigonometry",
                icon: Icons.architecture,
                color: Colors.tealAccent,
                screen: TrigonometryScreen(),
            ),
            _CategoryCard(
                title: "Electric",
                icon: Icons.electrical_services,
                color: Colors.greenAccent,
                screen: ConverterElectricScreen(),
            ),
            _CategoryCard(
                title: "Typography",
                icon: Icons.text_fields,
                color: Colors.lightGreen,
                screen: ConverterTypographyScreen(),
            ),
            _CategoryCard(
                title: "Numeral",
                icon: Icons.tag,
                color: Colors.deepPurpleAccent,
                screen: ConverterNumeralScreen()
            ),
            _CategoryCard(
                title: "Image Converter",
                icon: Icons.image,
                color: Colors.lightGreen,
                screen: ConverterImageScreen(),
            ),
            _CategoryCard(
                title: "Document Converter",
                icon: Icons.document_scanner,
                color: Colors.lightBlue,
                requiresInternet: true,
                screen: ConverterDocumentFormatScreen(),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget? screen;
  final bool requiresInternet;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    this.screen,
    this.requiresInternet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          if (requiresInternet) {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult.contains(ConnectivityResult.none)) {
              _showNoInternetDialog(context);
              return;
            }
          }

          if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen!),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$title is under development",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: color.withOpacity(0.8),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 42),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12121A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.orange, width: 1.2),
        ),
        title: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.orange),
            SizedBox(width: 10),
            Text("No Connection", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Text(
          "This feature requires an active internet connection. Please check your settings.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
}