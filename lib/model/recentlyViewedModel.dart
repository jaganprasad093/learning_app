class RecentlyViewedModel {
  String? status;
  Data? data;

  RecentlyViewedModel({
    this.status,
    this.data,
  });

  factory RecentlyViewedModel.fromJson(Map<String, dynamic> json) =>
      RecentlyViewedModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<Datum>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  var coursePrice;
  bool? bestSeller;
  int? rating;
  int? ratingCount;
  bool? wishList;

  Datum({
    this.id,
    this.instructorName,
    this.courseName,
    this.courseThumbnail,
    this.coursePrice,
    this.bestSeller,
    this.rating,
    this.ratingCount,
    this.wishList,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        instructorName: json["instructor_name"],
        courseName: json["course_name"],
        courseThumbnail: json["course_thumbnail"],
        coursePrice: json["course_price"],
        bestSeller: json["best_seller"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        wishList: json["wish_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor_name": instructorName,
        "course_name": courseName,
        "course_thumbnail": courseThumbnail,
        "course_price": coursePrice,
        "best_seller": bestSeller,
        "rating": rating,
        "rating_count": ratingCount,
        "wish_list": wishList,
      };
}
