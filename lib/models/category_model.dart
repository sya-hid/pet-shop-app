class CategoryModel {
  String? image, text;
  int? id;

  CategoryModel({id, required this.image, required this.text});
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    image = json['image'];
  }
}
