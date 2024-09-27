class LearningDetailModel {
  String? status;
  List<Datum>? data;

  LearningDetailModel({
    this.status,
    this.data,
  });

  factory LearningDetailModel.fromJson(Map<String, dynamic> json) =>
      LearningDetailModel(
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
  String? video;
  String? thumbnail;
  int? rating;
  int? ratingCount;
  String? topicName;
  String? description;
  String? videoDuration;
  dynamic videoLink;
  String? youtubeVideo;
  String? imagePpoi;
  String? watchDuration;
  bool? isActive;
  int? course;
  int? section;

  Datum({
    this.id,
    this.video,
    this.thumbnail,
    this.rating,
    this.ratingCount,
    this.topicName,
    this.description,
    this.videoDuration,
    this.videoLink,
    this.youtubeVideo,
    this.imagePpoi,
    this.watchDuration,
    this.isActive,
    this.course,
    this.section,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        video: json["video"],
        thumbnail: json["thumbnail"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        topicName: json["topic_name"],
        description: json["description"],
        videoDuration: json["video_duration"],
        videoLink: json["video_link"],
        youtubeVideo: json["youtube_video"],
        imagePpoi: json["image_ppoi"],
        watchDuration: json["watch_duration"],
        isActive: json["is_active"],
        course: json["course"],
        section: json["section"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "thumbnail": thumbnail,
        "rating": rating,
        "rating_count": ratingCount,
        "topic_name": topicName,
        "description": description,
        "video_duration": videoDuration,
        "video_link": videoLink,
        "youtube_video": youtubeVideo,
        "image_ppoi": imagePpoi,
        "watch_duration": watchDuration,
        "is_active": isActive,
        "course": course,
        "section": section,
      };
}
