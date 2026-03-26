class ProductModel {
  final String name;
  final String image;
  final String origin;
  final String manufacturing;
  final String ingredients;
  final String countries;
  final String ecoGrade;
  final double co2;
  final String authenticity;
  final double sustainabilityScore;

  ProductModel({
    required this.name,
    required this.image,
    required this.origin,
    required this.manufacturing,
    required this.ingredients,
    required this.countries,
    required this.ecoGrade,
    required this.co2,
    required this.authenticity,
    required this.sustainabilityScore,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "co2": co2,
        "score": sustainabilityScore,
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      image: json["image"],
      origin: "",
      manufacturing: "",
      ingredients: "",
      countries: "",
      ecoGrade: "",
      co2: json["co2"],
      authenticity: "",
      sustainabilityScore: json["score"],
    );
  }
}