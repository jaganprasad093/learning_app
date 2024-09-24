import 'package:flutter/material.dart';
import 'package:learning_app/controller/homepage_controller/homepage_controller.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:provider/provider.dart';

class SeeAllPage extends StatefulWidget {
  final String caption;
  final String value;

  const SeeAllPage({super.key, required this.caption, required this.value});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoadingInitial = true;
  int pageSize = 5;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadInitialData();
  }

  void _loadInitialData() async {
    await _loadMoreData();
    setState(() {
      isLoadingInitial = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.caption,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HomepageController>(
        builder: (context, controller, child) {
          List? data;
          int itemCount;

          if (widget.value == "featured") {
            data = controller.featuredCoursesModel?.data;
            itemCount = data?.length ?? 0;
          } else if (widget.value == "top") {
            data = controller.topCoursesModel?.data;
            itemCount = data?.length ?? 0;
          } else if (widget.value == "recently") {
            data = controller.recentlyViewedModel?.data?.data;
            itemCount = data?.length ?? 0;
          } else {
            data = controller.recommendedModel?.data;
            itemCount = data?.length ?? 0;
          }

          if (isLoadingInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index < itemCount) {
                var courseData = data?[index];
                if (courseData == null) return SizedBox();

                String authorName = courseData.instructor?.name ?? "";
                String courseName = courseData.courseName ?? "";
                var price = courseData.price ?? "";
                String photo = courseData.thumbnail?.fullSize ?? "";
                String description = courseData.description ?? "";
                var id = courseData.id ?? "";
                var rating = courseData.rating ?? 0;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          id: id,
                        ),
                      ),
                    );
                  },
                  child: HorizontalCard(
                    rating: rating,
                    courseID: id,
                    isWishlist: false,
                    index: index,
                    description: description,
                    author_name: authorName,
                    course_name: courseName,
                    photo: photo,
                    price: price,
                    islearning: false,
                  ),
                );
              } else if (isLoadingMore) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: itemCount + (isLoadingMore ? 1 : 0),
          );
        },
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        setState(() {
          isLoadingMore = true;
        });
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData() async {
    await context.read<HomepageController>().getCategoryList();
    await context.read<HomepageController>().getFeaturedCourse();
    await context.read<HomepageController>().getRecommendedCourses();
    await context.read<HomepageController>().getTopCourses();
    setState(() {
      isLoadingMore = false;
    });
  }
}
