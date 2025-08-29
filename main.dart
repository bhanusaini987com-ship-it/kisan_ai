
import 'package:flutter/material.dart';
import 'features/diagnose/page_diagnose.dart';
import 'features/soil/page_soil.dart';
import 'features/water/page_water.dart';
import 'features/suggest/page_suggest.dart';
import 'features/history/page_history.dart';

void main() => runApp(const KisanAI());

class KisanAI extends StatelessWidget {
  const KisanAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('रोग पहचान (Diagnose)', Icons.healing, const DiagnosePage()),
      ('मिट्टी उर्वरता (Soil)', Icons.grass, const SoilPage()),
      ('पानी की ज़रूरत (Water)', Icons.water, const WaterPage()),
      ('फसल/रोटेशन सुझाव', Icons.agriculture, const SuggestPage()),
      ('इतिहास (History)', Icons.history, const HistoryPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Kisan AI')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          final (title, icon, page) = items[i];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(icon),
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
            ),
          );
        },
      ),
    );
  }
}
