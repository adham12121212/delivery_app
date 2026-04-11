
class OrderModel {
   final String id;
   final String name;
   final String status;
   final double price;
   final String image;

   OrderModel(
       { required this.id,
         required this.name,
         required this.status,
         required this.price,
         required this.image
       });

   factory OrderModel.fromJson(Map<String, dynamic> json,String id) {
     return OrderModel(
         id: id,
         name: json['name'],
         status: json['status'],
         price: (json['price'] ?? 0).toDouble(),
         image: json['image']
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'name': name,
       'status': status,
       'price': price,
       'image': image
     };
   }
}