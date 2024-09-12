class CartModel {
  String? message;
  Data? data;

  CartModel({
    this.message,
    this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? user;
  var grandTotal;
  List<CartItem>? cartItem;

  Data({
    this.user,
    this.grandTotal,
    this.cartItem,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"],
        grandTotal: json["grand_total"],
        cartItem: json["cart_item"] == null
            ? []
            : List<CartItem>.from(
                json["cart_item"]!.map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "grand_total": grandTotal,
        "cart_item": cartItem == null
            ? []
            : List<dynamic>.from(cartItem!.map((x) => x.toJson())),
      };
}

class CartItem {
  int? courseId;
  String? courseName;
  String? courseImage;
  int? rating;
  String? autherName;
  bool? bestSeller;
  Section? section;
  var price;
  bool? wishList;

  CartItem({
    this.courseId,
    this.courseName,
    this.courseImage,
    this.rating,
    this.autherName,
    this.bestSeller,
    this.section,
    this.price,
    this.wishList,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        courseId: json["course_id"],
        courseName: json["course_name"],
        courseImage: json["course_image"],
        rating: json["rating"],
        autherName: json["auther_name"],
        bestSeller: json["best_seller"],
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
        price: json["price"],
        wishList: json["wish_list"],
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "course_name": courseName,
        "course_image": courseImage,
        "rating": rating,
        "auther_name": autherName,
        "best_seller": bestSeller,
        "section": section?.toJson(),
        "price": price,
        "wish_list": wishList,
      };
}

class Section {
  int? id;
  String? name;
  int? amountPerc;
  bool? isActive;

  Section({
    this.id,
    this.name,
    this.amountPerc,
    this.isActive,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        amountPerc: json["amount_perc"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount_perc": amountPerc,
        "is_active": isActive,
      };
}
