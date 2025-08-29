Kisan AI (Flutter) — Offline-first demo
======================================

Quick Start (Android):
1) Install Flutter SDK on a PC or use an online IDE (Replit/Codespaces).
2) In terminal: flutter create kisan_ai && cd kisan_ai
3) Replace the generated lib/, assets/, and pubspec.yaml with the ones in this ZIP (or copy into the same paths).
4) flutter pub get
5) flutter run   (or: flutter build apk)

Notes:
- Disease detection uses a TFLite model. A placeholder is included so the app runs.
  When you have a real model file, replace: assets/tflite/disease_model.tflite
- All calculators and suggestions work offline from JSON tables.
- UI is bilingual-friendly, currently in Hindi labels.

Made for Bhanu's science project: AI-Powered Crop & Soil Management System.
