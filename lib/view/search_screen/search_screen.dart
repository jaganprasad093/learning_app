import 'package:flutter/material.dart';
import 'package:learning_app/controller/search_controller/SearchController.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/search_screen/widgets/CustomSearchCard.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search_controller = TextEditingController();
  @override
  void initState() {
    context.read<SearchCourseController>().getSearchCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<SearchCourseController>();
    var getLen = provider.searchmodel?.data;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                      onChanged: (p0) {
                        // if (search_controller.text != null ||
                        //     search_controller.text.length > 0) {

                        // }
                        provider.searchData(search_controller.text);
                      },
                      suffixIcon: search_controller.text.isEmpty
                          ? SizedBox()
                          : InkWell(
                              onTap: () async {
                                search_controller.clear();
                                provider.searchData(search_controller.text);
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
                    ? Text(
                        "Browse Courses",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    : SizedBox(),
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.isEmpty
                        ? Center(
                            child: Container(
                                height: 400,
                                child:
                                    Center(child: Text("No result found !"))))
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              // childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: (getLen?.length ?? 0) < 8
                                ? (getLen?.length ?? 0)
                                : 8,
                            itemBuilder: (context, index) {
                              var data = provider.searchmodel?.data?[index];
                              var photo = data?.thumbnail?.fullSize;
                              var author_name = data?.instructor?.name;
                              var courseID = data?.id;
                              var courseName = data?.courseName;
                              var price = data?.price.toInt();
                              var rating = data?.ratingCount;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          id: courseID ?? 0,
                                          navigation: "search",
                                        ),
                                      ));
                                },
                                child: CustomSearchCard(
                                  photo: photo ?? "",
                                  author_name: author_name ?? "",
                                  courseID: courseID ?? 0,
                                  name: courseName ?? "",
                                  price: price ?? 0,
                                  rating: rating ?? 0,
                                  index: index,
                                ),
                              );
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
