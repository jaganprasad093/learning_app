class WishlistModel {
  int? courseId;
  String? courseName;
  String? courseImage;
  int? rating;
  String? autherName;
  Section? section;
  num? price;

  WishlistModel(
      {this.courseId,
      this.courseName,
      this.courseImage,
      this.rating,
      this.autherName,
      this.section,
      this.price});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseImage = json['course_image'];
    rating = json['rating'];
    autherName = json['auther_name'];
    section =
        json['section'] != null ? new Section.fromJson(json['section']) : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['course_image'] = this.courseImage;
    data['rating'] = this.rating;
    data['auther_name'] = this.autherName;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    data['price'] = this.price;
    return data;
  }
}

class Section {
  int? id;
  String? name;
  num? amountPerc;
  bool? isActive;

  Section({this.id, this.name, this.amountPerc, this.isActive});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amountPerc = json['amount_perc'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount_perc'] = this.amountPerc;
    data['is_active'] = this.isActive;
    return data;
  }
}
