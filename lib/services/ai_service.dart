class AIService {
  static String generateInsight(String name, double co2, String eco) {
    if (co2 < 1) {
      return "$name has a low carbon footprint and is environmentally friendly.";
    } else if (co2 < 2) {
      return "$name has moderate environmental impact. Consider alternatives.";
    } else {
      return "$name has high carbon emissions. Not sustainable.";
    }
  }
}