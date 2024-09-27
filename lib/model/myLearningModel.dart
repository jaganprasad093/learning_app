class MyLearningModel {
  String? status;
  List<Datum>? data;

  MyLearningModel({
    this.status,
    this.data,
  });

  factory MyLearningModel.fromJson(Map<String, dynamic> json) =>
      MyLearningModel(
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
  int? courseId;
  var itemTotal;
  int? order;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  String? sectionId;
  int? rating;
  int? ratingCount;

  Datum({
    this.courseId,
    this.itemTotal,
    this.order,
    this.instructorName,
    this.courseName,
    this.courseThumbnail,
    this.sectionId,
    this.rating,
    this.ratingCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        courseId: json["course_id"],
        itemTotal: json["item_total"],
        order: json["order"],
        instructorName: json["instructor_name"],
        courseName: json["course_name"],
        courseThumbnail: json["course_thumbnail"],
        sectionId: json["section_id"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "item_total": itemTotal,
        "order": order,
        "instructor_name": instructorName,
        "course_name": courseName,
        "course_thumbnail": courseThumbnail,
        "section_id": sectionId,
        "rating": rating,
        "rating_count": ratingCount,
      };
}
