class MenuModel {
  final String id;
  final String image;
  final String name;
  final String price;
  final String menuCategory;
  final bool isAvailable;

  MenuModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.menuCategory,
    required this.isAvailable,
  });

  factory MenuModel.fromJson(
      Map<String, dynamic> json,
      String id,
      ) {
    return MenuModel(
      id: id,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      price: json['price']??'' ,
      menuCategory: json['menuCategory'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  factory MenuModel.mock() {
    return MenuModel(
      id: '0',
      name: 'Loading Item',
      price: 'Loading',
      menuCategory: 'Loading',
      isAvailable: true,
      image: '',
    );
  }
}