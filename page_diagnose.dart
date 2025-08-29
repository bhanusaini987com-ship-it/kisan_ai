
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'service_tflite.dart';

class DiagnosePage extends StatefulWidget {
  const DiagnosePage({super.key});
  @override
  State<DiagnosePage> createState() => _DiagnosePageState();
}

class _DiagnosePageState extends State<DiagnosePage> {
  final _picker = ImagePicker();
  File? _image;
  String? _result;
  bool _busy = false;
  final _detector = DiseaseDetector();

  @override
  void initState() {
    super.initState();
    _detector.init();
  }

  Future<void> _pick(ImageSource src) async {
    final x = await _picker.pickImage(source: src, imageQuality: 85);
    if (x == null) return;
    setState(() { _image = File(x.path); _busy = true; _result = null; });
    try {
      final res = await _detector.predictFromFile(_image!);
      setState(() => _result = "${res['label']} (conf: ${(res['confidence']*100).toStringAsFixed(1)}%)");
    } catch (e) {
      setState(() => _result = "मॉडल उपलब्ध नहीं है / त्रुटि: $e");
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('रोग पहचान (Diagnose)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_image != null) Expanded(child: Image.file(_image!, fit: BoxFit.contain)),
            const SizedBox(height: 12),
            if (_result != null) Text(_result!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            if (_busy) const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: () => _pick(ImageSource.camera), icon: const Icon(Icons.camera_alt), label: const Text('कैमरा')),
                ElevatedButton.icon(onPressed: () => _pick(ImageSource.gallery), icon: const Icon(Icons.photo), label: const Text('गैलरी')),
              ],
            ),
            const SizedBox(height: 8),
            const Text('नोट: असली मॉडल जोड़ने पर सही पहचान होगी।', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
