class ShopLoginModel{
  bool? status ;
  String? message;
  UserData? data ;
  ShopLoginModel(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData(json['data']) : null;
  }

}
class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];

  }


}




// "status": true,
// "message": "Login done successfully",
// "data": {
// "id": 20340,
// "name": "mina zarif",
// "email": "minazarif@gmail.com",
// "phone": "12345678990",
// "image": "https://student.valuxapps.com/storage/uploads/users/qjWaUkZQ1s_1664389797.jpeg",
// "points": 0,
// "credit": 0,
// "token": "HrTFw5IEYLyvJzOVHTgY9dYQyzjnXv6ovLn1VE3KaV3X7cVWofdREgY07Dti4KU3uqhody"
// }