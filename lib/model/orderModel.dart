class OrderModel {
  String? message;
  List<Datum>? data;

  OrderModel({
    this.message,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
  DateTime? createdAt;
  var grandTotal;
  var totalAmount;
  var discountAmount;
  List<String>? paymentMethod;
  String? status;
  int? user;
  dynamic promoCode;
  dynamic promoCodeName;
  String? orderId;
  List<OrderedCourseOrder>? orderedCourseOrder;

  Datum({
    this.id,
    this.createdAt,
    this.grandTotal,
    this.totalAmount,
    this.discountAmount,
    this.paymentMethod,
    this.status,
    this.user,
    this.promoCode,
    this.promoCodeName,
    this.orderId,
    this.orderedCourseOrder,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        grandTotal: json["grand_total"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        paymentMethod: json["payment_method"] == null
            ? []
            : (json["payment_method"] is String
                ? [json["payment_method"]]
                : List<String>.from(json["payment_method"].map((x) => x))),
        status: json["status"],
        user: json["user"],
        promoCode: json["promo_code"],
        promoCodeName: json["promo_code_name"],
        orderId: json["order_id"],
        orderedCourseOrder: json["ordered_course_order"] == null
            ? []
            : List<OrderedCourseOrder>.from(json["ordered_course_order"]
                .map((x) => OrderedCourseOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "grand_total": grandTotal,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "payment_method": paymentMethod == null
            ? []
            : List<dynamic>.from(paymentMethod!.map((x) => x)),
        "status": status,
        "user": user,
        "promo_code": promoCode,
        "promo_code_name": promoCodeName,
        "order_id": orderId,
        "ordered_course_order": orderedCourseOrder == null
            ? []
            : List<dynamic>.from(orderedCourseOrder!.map((x) => x.toJson())),
      };
}

class OrderedCourseOrder {
  int? courseId;
  var itemTotal;
  int? order;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  String? sectionId;
  int? rating;
  int? ratingCount;

  OrderedCourseOrder({
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

  factory OrderedCourseOrder.fromJson(Map<String, dynamic> json) =>
      OrderedCourseOrder(
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
