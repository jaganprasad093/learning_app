class CategoryListModel {
  String? message;
  List<Datum>? data;

  CategoryListModel({
    this.message,
    this.data,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? categoryName;
  String? categoryIcon;
  String? categoryIconImage;

  Datum({
    this.id,
    this.categoryName,
    this.categoryIcon,
    this.categoryIconImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"],
        categoryIcon: json["category_icon"],
        categoryIconImage: json["category_icon_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_icon": categoryIcon,
        "category_icon_image": categoryIconImage,
      };
}
