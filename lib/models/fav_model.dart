class FavoriteModel {
  bool? status;
  FavoriteModelData? data;


  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new FavoriteModelData.fromJson(json['data']) : null;
  }

 
}

class FavoriteModelData {
  int? currentPage;
  List<Product>? product = [];


  FavoriteModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((elem){
      product!.add(Product.fromJson(elem));
    });
  }

}

class Product {
  int? id;
  Data? data;

  

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = Data.fromJson(json['product']);
  }

}

class Data {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;

    Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }

}
