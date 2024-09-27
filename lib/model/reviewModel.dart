class ReviewsModel {
  String? status;
  List<Datum>? data;

  ReviewsModel({
    this.status,
    this.data,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? rating;
  String? review;
  DateTime? createdAt;
  int? user;
  int? course;

  Datum({
    this.id,
    this.rating,
    this.review,
    this.createdAt,
    this.user,
    this.course,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "review": review,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "user": user,
        "course": course,
      };
}
