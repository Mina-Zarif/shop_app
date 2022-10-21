class ChangeFavoriteModel {
  bool? status;
  String? message;

  ChangeFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
//////////

class GetFavoriteModel {
  bool? status;
  String? message;
  GetFavoriteDataModel? data;
  GetFavoriteModel.fromJson(Map<String,dynamic>json){
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

class DataModel {
  int? id;
  ProductModel? product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  int? productId;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

