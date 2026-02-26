
class OfferModel {
  final String id;
  final String image;
  final String title;

  OfferModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json, String id) {
    return OfferModel(
      id: id,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }



}
