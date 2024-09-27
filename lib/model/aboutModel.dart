class AboutModel {
  String? message;
  List<Datum>? data;

  AboutModel({
    this.message,
    this.data,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
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
  String? title;
  String? aboutApp;

  Datum({
    this.title,
    this.aboutApp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        aboutApp: json["about_app"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "about_app": aboutApp,
      };
}
