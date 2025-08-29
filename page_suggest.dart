
import 'package:flutter/material.dart';
import 'rotation_logic.dart';

class SuggestPage extends StatefulWidget {
  const SuggestPage({super.key});
  @override
  State<SuggestPage> createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  final prevCtrl = ValueNotifier<String>('wheat');
  List<String> next = Rotation.suggestNext('wheat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('फसल/रोटेशन सुझाव')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(value: prevCtrl.value, items: const [
              DropdownMenuItem(value: 'wheat', child: Text('Wheat')),
              DropdownMenuItem(value: 'rice', child: Text('Rice')),
              DropdownMenuItem(value: 'cotton', child: Text('Cotton')),
              DropdownMenuItem(value: 'mustard', child: Text('Mustard')),
            ], onChanged: (v){
              final pv = v as String;
              setState(() { prevCtrl.value = pv; next = Rotation.suggestNext(pv); });
            }, decoration: const InputDecoration(labelText: 'पिछली फसल')),
            const SizedBox(height: 12),
            const Text('अगली उपयुक्त फसलें:'),
            const SizedBox(height: 6),
            ...next.map((e) => ListTile(leading: const Icon(Icons.check), title: Text(e))),
          ],
        ),
      ),
    );
  }
}
