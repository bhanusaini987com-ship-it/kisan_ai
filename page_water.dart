
import 'package:flutter/material.dart';
import 'water_calc.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});
  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final crop = ValueNotifier<String>('wheat');
  final stage = ValueNotifier<String>('initial');
  final area = TextEditingController(text: '100'); // m^2
  final tmin = TextEditingController(text: '20');
  final tmax = TextEditingController(text: '34');
  double? litres;

  void _calc() {
    final l = WaterCalc.dailyLitres(
      crop: crop.value,
      stage: stage.value,
      areaM2: double.tryParse(area.text) ?? 100,
      tmin: double.tryParse(tmin.text) ?? 20,
      tmax: double.tryParse(tmax.text) ?? 34,
    );
    setState(() => litres = l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('पानी की ज़रूरत (Water)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField(value: crop.value, items: const [
            DropdownMenuItem(value: 'wheat', child: Text('Wheat')),
            DropdownMenuItem(value: 'rice', child: Text('Rice')),
            DropdownMenuItem(value: 'cotton', child: Text('Cotton')),
          ], onChanged: (v){ setState(()=> crop.value = v as String); }, decoration: const InputDecoration(labelText: 'Crop')),
          DropdownButtonFormField(value: stage.value, items: const [
            DropdownMenuItem(value: 'initial', child: Text('Initial')),
            DropdownMenuItem(value: 'mid', child: Text('Mid')),
            DropdownMenuItem(value: 'late', child: Text('Late')),
          ], onChanged: (v){ setState(()=> stage.value = v as String); }, decoration: const InputDecoration(labelText: 'Growth Stage')),
          TextField(controller: area, decoration: const InputDecoration(labelText: 'Area (m²)')),
          Row(children: [
            Expanded(child: TextField(controller: tmin, decoration: const InputDecoration(labelText: 'Tmin °C'))),
            const SizedBox(width: 12),
            Expanded(child: TextField(controller: tmax, decoration: const InputDecoration(labelText: 'Tmax °C'))),
          ]),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _calc, child: const Text('Calculate')),
          if (litres != null) Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text('Suggested water today: ${litres!.toStringAsFixed(0)} L', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
