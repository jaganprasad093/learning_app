import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controller/review_controller/ReviewController.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  final int course_id;
  final String courseName;
  const AddReview({
    super.key,
    required this.course_id,
    required this.courseName,
  });

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  @override
  void initState() {
    // context.read<Reviewcontroller>().getReviews(widget.courseID);
    context.read<Reviewcontroller>().getReviews(widget.course_id);
    super.initState();
  }

  int selectedRating = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController RatingController = TextEditingController();
    var provider = context.watch<Reviewcontroller>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Review " + "${widget.courseName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Tap to rate",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRating = index + 1;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              size: 50,
                              color: index < selectedRating
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                      // StarRating(
                      //   rating: 5,
                      //   size: 50,
                      // ),
                      SizedBox(
                        height: 40,
                      ),

                      Text(
                        "Tell us more (optional)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          maxLines: 3,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter the rating';
                            }
                          },
                          controller: RatingController,
                          hintText: "Why this rating ?"),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        text: "Submit",
                        onTap: () {
                          log("selected index=====$selectedRating");
                          provider.AddReview(5, widget.course_id,
                              RatingController.text, context);
                        },
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text("Popular reviews",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          )),
                      Divider(),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsetsDirectional.only(top: 10),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = provider.reviewsModel?.data?[index];
                          String inputDate = data?.createdAt.toString() ?? "";
                          DateTime parsedDate = DateTime.parse(inputDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(parsedDate);

                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StarRating(rating: data?.rating ?? 0),
                                        SizedBox(width: 10),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    data?.review ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemCount: provider.reviewsModel?.data?.length ?? 0,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
