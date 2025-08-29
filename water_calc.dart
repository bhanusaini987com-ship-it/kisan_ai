
class WaterCalc {
  static double etoFromTemp(double tmin, double tmax) {
    final tmean = (tmin + tmax) / 2;
    if (tmean >= 35) return 7.0;
    if (tmean >= 30) return 6.0;
    if (tmean >= 25) return 5.0;
    if (tmean >= 20) return 4.0;
    if (tmean >= 15) return 3.5;
    return 3.0;
    }

  static double kc(String crop, String stage) {
    const table = {
      'wheat': {'initial': 0.4, 'mid': 1.15, 'late': 0.35},
      'rice':  {'initial': 1.05, 'mid': 1.20, 'late': 0.90},
      'cotton':{'initial': 0.35, 'mid': 1.15, 'late': 0.60},
    };
    return (table[crop]![stage] ?? 1.0);
  }

  static double dailyLitres({
    required String crop,
    required String stage,
    required double areaM2,
    required double tmin,
    required double tmax,
  }) {
    final eto = etoFromTemp(tmin, tmax);
    final etc = kc(crop, stage) * eto; // mm/day
    return etc * areaM2; // L/day
  }
}
