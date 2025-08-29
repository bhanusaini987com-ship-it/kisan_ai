
import 'package:flutter/material.dart';
import 'soil_logic.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});
  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  final phCtrl = TextEditingController(text: '7.0');
  final ecCtrl = TextEditingController(text: '1.0');
  final orgCtrl = TextEditingController(text: '1');

  String? level;
  List<String> advice = [];

  void _calc() {
    final ph = double.tryParse(phCtrl.text) ?? 7.0;
    final ec = double.tryParse(ecCtrl.text) ?? 1.0;
    final org = int.tryParse(orgCtrl.text) ?? 1;
    final l = SoilFertility.level(ph: ph, ecMs: ec, organicPct: org);
    setState(() { level = l; advice = SoilFertility.advice(l); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('मिट्टी उर्वरता (Soil)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: phCtrl, decoration: const InputDecoration(labelText: 'pH')),
          TextField(controller: ecCtrl, decoration: const InputDecoration(labelText: 'EC (dS/m)')),
          TextField(controller: orgCtrl, decoration: const InputDecoration(labelText: 'जैविक पदार्थ %')),          
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _calc, child: const Text('जाँचें')),
          if (level != null) ...[
            const SizedBox(height: 12),
            Text('स्तर: $level', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...advice.map((e) => ListTile(leading: const Icon(Icons.check), title: Text(e))),
          ]
        ],
      ),
    );
  }
}
