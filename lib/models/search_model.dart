class SearchModel {
  bool? status;
  SearchModelData? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SearchModelData.fromJson(json['data']) : null;
  }

 
}

class SearchModelData {
  int? currentPage;
  List<ProductData>? product = [];


  SearchModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((elem){
      product!.add(ProductData.fromJson(elem));
    });
  }

}


class ProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;

    ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }

}
