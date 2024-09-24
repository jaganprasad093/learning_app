import 'package:flutter/material.dart';
import 'package:learning_app/controller/category_controller/category_controller.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';
import 'package:provider/provider.dart';

class Subcategories extends StatefulWidget {
  final int id;
  const Subcategories({super.key, required this.id});

  @override
  State<Subcategories> createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  @override
  void initState() {
    context.read<CategoryController>().getSubCategories(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<CategoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subcategories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var data = provider.categorymodel?.data?[index];
            var photo = data?.thumbnail?.fullSize ?? "";
            var price = data?.price ?? 0;
            var author_name = data?.instructor?.name ?? "";
            var course_name = data?.courseName ?? "";
            var description = data?.description ?? "";
            var courseID = data?.id ?? 0;
            var rating = data?.ratingCount ?? 0;
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(id: courseID),
                    ));
              },
              child: HorizontalCard(
                  islearning: false,
                  photo: photo,
                  author_name: author_name,
                  price: price,
                  course_name: course_name,
                  description: description,
                  index: index,
                  isWishlist: false,
                  courseID: courseID,
                  rating: rating),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: provider.subCategoryModel?.data?.length ?? 0),
    );
  }
}
