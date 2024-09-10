import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  String? message;
  List<Datum>? data;

  BannerModel({
    this.message,
    this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
  String? name;
  List<BannerImg>? bannerImg;
  String? description;
  dynamic publishDate;
  dynamic expireAt;

  Datum({
    this.id,
    this.name,
    this.bannerImg,
    this.description,
    this.publishDate,
    this.expireAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        bannerImg: json["banner_img"] == null
            ? []
            : List<BannerImg>.from(
                json["banner_img"]!.map((x) => BannerImg.fromJson(x))),
        description: json["description"],
        publishDate: json["publish_date"],
        expireAt: json["expire_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "banner_img": bannerImg == null
            ? []
            : List<dynamic>.from(bannerImg!.map((x) => x.toJson())),
        "description": description,
        "publish_date": publishDate,
        "expire_at": expireAt,
      };
}

class BannerImg {
  String? bannerImg;
  int? actionId;

  BannerImg({
    this.bannerImg,
    this.actionId,
  });

  factory BannerImg.fromJson(Map<String, dynamic> json) => BannerImg(
        bannerImg: json["banner_img"],
        actionId: json["action_id"],
      );

  Map<String, dynamic> toJson() => {
        "banner_img": bannerImg,
        "action_id": actionId,
      };
}
