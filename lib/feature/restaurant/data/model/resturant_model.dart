class ResturantModel {
  final String title;
  final String category;
  final String image;
  final String deliveryTime;
  final String deliveryPrice;
  final String rating;
  final String id;


  ResturantModel({
    required this.id,
    required this.rating,
    required this.image,
    required this.title,
    required this.category,
    required this.deliveryPrice,
    required this.deliveryTime
  });

  factory ResturantModel.fromJson(Map<String, dynamic> json, String id) {
    return ResturantModel(
      id: id,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      category: json['category']??'',
      deliveryPrice: json['deliveryPrice']??'',
      deliveryTime: json['deliveryTime']??'',
      rating: json['rating']??'',
    );
  }

  factory ResturantModel.fake() {
    return ResturantModel(
      id: '',
      title: 'Loading...',
      image: '',
      deliveryTime: '...',
      deliveryPrice: '...',
      rating: '',
      category: '',
    );
  }
}