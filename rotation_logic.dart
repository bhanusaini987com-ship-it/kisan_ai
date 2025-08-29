
class Rotation {
  static const Map<String, List<String>> nextCrops = {
    'wheat': ['mung bean', 'cowpea', 'sesame'],
    'rice':  ['mustard', 'potato', 'lentil'],
    'cotton':['chickpea', 'wheat'],
    'mustard':['maize', 'green gram'],
  };

  static List<String> suggestNext(String previousCrop) =>
      nextCrops[previousCrop.toLowerCase()] ?? ['legumes', 'millets'];
}
