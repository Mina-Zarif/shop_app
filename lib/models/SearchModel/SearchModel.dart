
class SearchModel {
  bool? status;
  String? message;
  GetFavoriteDataModel? data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = GetFavoriteDataModel.fromJson(json['data']);
  }
}

class GetFavoriteDataModel {
  int? currentPage;
  List<DataModel> data = [];

  GetFavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
//
// class DataModel {
//   int? id;
//   ProductModel? product;
//
//   DataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product = ProductModel.fromJson(json['product']);
//   }
// }

class DataModel {
  int? productId;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  DataModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

