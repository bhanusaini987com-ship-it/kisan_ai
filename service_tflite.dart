
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/material.dart';

class DiseaseDetector {
  tfl.Interpreter? _interpreter;
  List<String> labels = [];

  Future<void> init() async {
    try {
      // Try to load model
      _interpreter = await tfl.Interpreter.fromAsset('assets/tflite/disease_model.tflite',
          options: tfl.InterpreterOptions()..threads = 2);
      final raw = await rootBundle.loadString('assets/tflite/labels.txt');
      labels = raw.split('\n').where((e) => e.trim().isNotEmpty).toList();
    } catch (_) {
      // Fallback to demo mode
      _interpreter = null;
      labels = ['healthy', 'diseased'];
    }
  }

  Future<Map<String, dynamic>> predictFromFile(File f) async {
    if (_interpreter == null) {
      // Demo: random-ish result (no real ML) so the UI works.
      final conf = (DateTime.now().millisecondsSinceEpoch % 100) / 100.0;
      final label = conf > 0.5 ? 'healthy' : 'diseased';
      return {'label': label, 'confidence': conf};
    }
    // TODO: Implement real preprocessing to 1x224x224x3 float tensor and run model.
    // This placeholder returns a fixed value to avoid runtime crash.
    return {'label': labels.first, 'confidence': 0.99};
  }

  void dispose() => _interpreter?.close();
}
