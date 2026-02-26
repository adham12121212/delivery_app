
class ResturantModel {
  final String title;
  final String category;
  final String image;
  final String deliveryTime;
  final String deliveryPrice;

  ResturantModel({
    required this.image,
    required this.title,
    required this.category,
    required this.deliveryPrice,
    required this.deliveryTime
  });

  factory ResturantModel.fromJson(Map<String, dynamic> json) {
    return ResturantModel(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      category: json['category']??'',
      deliveryPrice: json['deliveryPrice']??'',
      deliveryTime: json['deliveryTime']??''
    );
  }
}