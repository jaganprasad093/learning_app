class SearchModel {
  String? message;
  List<Datum>? data;

  SearchModel({
    this.message,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
  String? courseName;
  String? description;
  var price;
  dynamic offerPrice;
  SubCategory? subCategory;
  DateTime? createdAt;
  dynamic updatedAt;
  bool? featuredCourse;
  bool? recommendedCourse;
  bool? bestSeller;
  Thumbnail? thumbnail;
  Instructor? instructor;
  String? introVideo;
  int? rating;
  int? ratingCount;
  bool? wishList;

  Datum({
    this.id,
    this.courseName,
    this.description,
    this.price,
    this.offerPrice,
    this.subCategory,
    this.createdAt,
    this.updatedAt,
    this.featuredCourse,
    this.recommendedCourse,
    this.bestSeller,
    this.thumbnail,
    this.instructor,
    this.introVideo,
    this.rating,
    this.ratingCount,
    this.wishList,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        courseName: json["course_name"],
        description: json["description"],
        price: json["price"],
        offerPrice: json["offer_price"],
        subCategory: json["sub_category"] == null
            ? null
            : SubCategory.fromJson(json["sub_category"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        featuredCourse: json["featured_course"],
        recommendedCourse: json["recommended_course"],
        bestSeller: json["best_seller"],
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
        instructor: json["instructor"] == null
            ? null
            : Instructor.fromJson(json["instructor"]),
        introVideo: json["intro_video"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        wishList: json["wish_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_name": courseName,
        "description": description,
        "price": price,
        "offer_price": offerPrice,
        "sub_category": subCategory?.toJson(),
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt,
        "featured_course": featuredCourse,
        "recommended_course": recommendedCourse,
        "best_seller": bestSeller,
        "thumbnail": thumbnail?.toJson(),
        "instructor": instructor?.toJson(),
        "intro_video": introVideo,
        "rating": rating,
        "rating_count": ratingCount,
        "wish_list": wishList,
      };
}

class Instructor {
  int? id;
  String? name;
  String? email;
  dynamic gender;
  dynamic dob;
  String? mobile;
  dynamic address;
  dynamic userSocialId;
  var isActive;
  var isAdmin;
  var isStaff;
  String? password;
  String? profilePic;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? imagePpoi;
  bool? isInstructor;
  String? instructorDocs;
  bool? isNotify;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  Instructor({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.dob,
    this.mobile,
    this.address,
    this.userSocialId,
    this.isActive,
    this.isAdmin,
    this.isStaff,
    this.password,
    this.profilePic,
    this.lastLogin,
    this.isSuperuser,
    this.imagePpoi,
    this.isInstructor,
    this.instructorDocs,
    this.isNotify,
    this.groups,
    this.userPermissions,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        dob: json["dob"],
        mobile: json["mobile"],
        address: json["address"],
        userSocialId: json["user_social_id"],
        isActive: json["is_active"],
        isAdmin: json["is_admin"],
        isStaff: json["is_staff"],
        password: json["password"],
        profilePic: json["profile_pic"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        imagePpoi: json["image_ppoi"],
        isInstructor: json["is_instructor"],
        instructorDocs: json["instructor_docs"],
        isNotify: json["is_notify"],
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? []
            : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "dob": dob,
        "mobile": mobile,
        "address": address,
        "user_social_id": userSocialId,
        "is_active": isActive,
        "is_admin": isAdmin,
        "is_staff": isStaff,
        "password": password,
        "profile_pic": profilePic,
        "last_login": lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser,
        "image_ppoi": imagePpoi,
        "is_instructor": isInstructor,
        "instructor_docs": instructorDocs,
        "is_notify": isNotify,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}

class SubCategory {
  int? id;
  String? subCategoryName;
  bool? isActive;
  int? category;

  SubCategory({
    this.id,
    this.subCategoryName,
    this.isActive,
    this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        subCategoryName: json["sub_category_name"],
        isActive: json["is_active"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_category_name": subCategoryName,
        "is_active": isActive,
        "category": category,
      };
}

class Thumbnail {
  String? thumbnail;
  String? fullSize;

  Thumbnail({
    this.thumbnail,
    this.fullSize,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        thumbnail: json["thumbnail"],
        fullSize: json["full_size"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "full_size": fullSize,
      };
}
