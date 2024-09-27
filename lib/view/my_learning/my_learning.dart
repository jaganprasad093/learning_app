import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/learning_controller/MyLearningController.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:learning_app/view/my_learning/widgets/LearningDetails.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/model/myLearningModel.dart' as myLearning;

class MyLearning extends StatefulWidget {
  const MyLearning({super.key});

  @override
  State<MyLearning> createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {
  @override
  void initState() {
    context.read<Mylearningcontroller>().getMyLearnings();
    super.initState();
  }

  List<myLearning.Datum> searchResults = [];
  TextEditingController search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Mylearningcontroller>();

    log("search results------$searchResults");
    log("search controller------${search_controller.text}");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SizedBox(),
        title: Text(
          "My learning",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: provider.myLearningModel?.data?.isEmpty == true
          ? Center(child: Text("Courses are not purchased !"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                        onChanged: (p0) async {
                          //  provider.myLearningModel?.data.contains()
                          searchResults.clear();
                          var search = await provider
                              .searchCourses(search_controller.text);

                          setState(() {
                            searchResults = search;
                            log("search results length ---${searchResults.length}");
                          });
                        },
                        suffixIcon: search_controller.text.isEmpty
                            ? SizedBox()
                            : InkWell(
                                onTap: () async {
                                  search_controller.clear();

                                  // provider
                                  //     .searchData(search_controller.text);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              ),
                        controller: search_controller,
                        hintText: "Search"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  search_controller.text.isEmpty
                      ? provider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              // padding: EdgeInsets.only(bottom: 100),
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data =
                                    provider.myLearningModel?.data?[index];

                                // log("length1------${provider.myLearningModel?.data?.length}");
                                // log("length1------${provider.myLearningModel?.data?[6].courseId}");
                                // log("id-------${data?.courseId}");
                                return InkWell(
                                  onTap: () {
                                    provider.detailLearningpage(
                                        data?.courseId ?? 0);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Learningdetails(
                                            courseID: data?.courseId ?? 0,
                                            courseName: data?.courseName ?? "",
                                          ),
                                        ));
                                  },
                                  child: HorizontalCard(
                                    iscart: true,
                                    rating: data?.rating ?? 0,
                                    courseID: data?.courseId ?? 0,
                                    isWishlist: false,
                                    index: index,
                                    description: "",
                                    author_name: data?.instructorName ?? "",
                                    course_name: data?.courseName ?? "",
                                    photo: data?.courseThumbnail ?? "",
                                    price: data?.itemTotal?.toInt() ?? 0,
                                    islearning: true,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: searchResults.isEmpty
                                  ? provider.myLearningModel?.data?.length ?? 0
                                  : searchResults.length)
                      : provider.isLoading
                          ? CircularProgressIndicator()
                          : searchResults.isEmpty &&
                                  search_controller.text.isNotEmpty
                              ? Container(
                                  height: 400,
                                  child: Center(child: Text("No data found !")))
                              : ListView.separated(
                                  // padding: EdgeInsets.only(bottom: 100),
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var data =
                                        provider.myLearningModel?.data?[index];
                                    var course = searchResults[index];

                                    // log("length1------${provider.myLearningModel?.data?.length}");
                                    // log("length1------${provider.myLearningModel?.data?[6].courseId}");
                                    // log("id-------${data?.courseId}");
                                    return InkWell(
                                      onTap: () {
                                        provider.detailLearningpage(
                                            data?.courseId ?? 0);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Learningdetails(
                                                courseName:
                                                    data?.courseName ?? "",
                                                courseID: data?.courseId ?? 0,
                                              ),
                                            ));
                                      },
                                      child: HorizontalCard(
                                        iscart: true,
                                        rating: searchResults.isEmpty
                                            ? data?.rating ?? 0
                                            : course.rating ?? 0,
                                        courseID: searchResults.isEmpty
                                            ? data?.courseId ?? 0
                                            : course.courseId ?? 0,
                                        isWishlist: false,
                                        index: index,
                                        description: "",
                                        author_name: searchResults.isEmpty
                                            ? data?.instructorName ?? ""
                                            : course.instructorName ?? "",
                                        course_name: searchResults.isEmpty
                                            ? data?.courseName ?? ""
                                            : course.courseName ?? "",
                                        photo: searchResults.isEmpty
                                            ? data?.courseThumbnail ?? ""
                                            : course.courseThumbnail ?? "",
                                        price: searchResults.isEmpty
                                            ? data?.itemTotal?.toInt() ?? 0
                                            : course.itemTotal.toInt() ?? "",
                                        islearning: true,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: searchResults.isEmpty
                                      ? provider
                                              .myLearningModel?.data?.length ??
                                          0
                                      : searchResults.length),
                ],
              ),
            ),
    );
  }
}
