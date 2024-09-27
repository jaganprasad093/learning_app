import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controller/review_controller/ReviewController.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final int courseID;
  final int? ratingCount;
  final int? rating;
  final int? totalReviees;

  const ReviewScreen(
      {super.key,
      required this.courseID,
      this.ratingCount,
      this.rating,
      this.totalReviees});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    context.read<Reviewcontroller>().getReviews(widget.courseID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Reviewcontroller>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StarRating(
                          rating: widget.rating ?? 0,
                          size: 40,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("${widget.ratingCount ?? 00.toDouble()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              // color: Colors.amber,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("${widget.ratingCount ?? 0}" + " reviews",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 23,
                            color: Colors.black.withOpacity(.5),
                          )),
                    ),
                    SizedBox(
                      height: 30,
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
                          return Row(
                            children: [
                              Column(
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${formattedDate}",
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    data?.review ?? "",
                                    style: TextStyle(
                                        // color: Colors.black.withOpacity(.5),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                        itemCount: provider.reviewsModel?.data?.length ?? 0),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
