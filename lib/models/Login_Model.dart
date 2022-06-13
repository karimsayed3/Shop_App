
class ShopLoginModel {
   bool status;
   String message;
   UserData data;

  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
   dynamic id;
     String name;
     String email;
     String phone;
     String image;
     String token;
   dynamic points;
   dynamic credit;


   UserData.fromJson(Map<String,dynamic> json)
  {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.token = json['token'];
    this.points = json['points'];
    this.credit = json['credit'];
  }
}
