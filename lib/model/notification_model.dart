class NotificationModel {
  String? message;
  List<Datum>? data;

  NotificationModel({
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
  String? mainIdentifier;
  String? subIdentifier;
  String? messageTitle;
  int? userId;
  String? notificationImage;
  String? createdAt;

  Datum({
    this.id,
    this.mainIdentifier,
    this.subIdentifier,
    this.messageTitle,
    this.userId,
    this.notificationImage,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        mainIdentifier: json["main_identifier"],
        subIdentifier: json["sub_identifier"],
        messageTitle: json["message_title"],
        userId: json["user_id"],
        notificationImage: json["notification_image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_identifier": mainIdentifier,
        "sub_identifier": subIdentifier,
        "message_title": messageTitle,
        "user_id": userId,
        "notification_image": notificationImage,
        "created_at": createdAt,
      };
}
