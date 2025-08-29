
class SoilFertility {
  static String level({required double ph, required double ecMs, required int organicPct}) {
    if (ph < 5.5 || ph > 8.5) return 'कम (pH सुधारें)';
    if (organicPct < 1) return 'कम (जैविक खाद बढ़ाएँ)';
    if (ecMs > 4) return 'कम (लवणीयता अधिक)';
    return 'अच्छा';
  }

  static List<String> advice(String level) {
    switch(level) {
      case 'कम (pH सुधारें)':
        return ['चूना/जिप्सम (pH पर निर्भर)', 'हरी खाद', 'जैविक कम्पोस्ट'];
      case 'कम (जैविक खाद बढ़ाएँ)':
        return ['FYM/वर्मी कम्पोस्ट', 'फसल अवशेष मिलाएँ'];
      case 'कम (लवणीयता अधिक)':
        return ['निकासी सुधारें', 'जिप्सम/मीठा पानी फ्लशिंग'];
      default:
        return ['मृदा स्वास्थ्य बनाए रखें', 'मल्चिंग', 'फसल चक्र अपनाएँ'];
    }
  }
}
