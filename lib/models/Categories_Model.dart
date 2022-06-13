class CategoryModel{
  bool status;
  DataModel data;
  CategoryModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
 }

 class DataModel {
   int current_page;
   var data = [];

   DataModel.fromJson(Map<String, dynamic> json){
     current_page = json['current_page'];
     json['data'].forEach((e) {
       data.add(e);
     });
   }
 }
