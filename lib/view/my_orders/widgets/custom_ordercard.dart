// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:learning_app/controller/OrderController/OrderController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/homepage/widgets/horizontal_card.dart';

class CustomOrdercard extends StatefulWidget {
  final int index;
  CustomOrdercard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomOrdercard> createState() => _CustomOrdercardState();
}

class _CustomOrdercardState extends State<CustomOrdercard> {
  @override
  void initState() {
    context.read<Ordercontroller>().getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<Ordercontroller>();
    var data = provider.orderModel?.data?[widget.index];
    var paymentMethod = data?.paymentMethod?.first ?? "";
    String cleanedPaymentMethod =
        paymentMethod.replaceAll(RegExp(r"[\[\]']"), "");

    var inputDate = data?.createdAt.toString() ?? "";
    DateTime parsedDate = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    log("formatted date---$formattedDate");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      color: Colors.grey.withOpacity(.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${formattedDate}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var datum = data?.orderedCourseOrder?[index];
                return HorizontalCard(
                    iscart: true,
                    islearning: false,
                    photo: datum?.courseThumbnail ?? "",
                    author_name: datum?.instructorName ?? "",
                    price: datum?.itemTotal ?? 0,
                    course_name: datum?.courseName ?? "",
                    description: datum?.sectionId ?? "",
                    index: index,
                    isWishlist: false,
                    courseID: datum?.courseId ?? 1,
                    rating: 2);
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: data?.orderedCourseOrder?.length ?? 0),
          Text(
            "Order ID: ${data?.orderId ?? 0}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Text(
            "Payment method: ${cleanedPaymentMethod}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total amount:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                "₹  ${data?.totalAmount ?? 0}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount amount:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                "₹   ${data?.discountAmount ?? 00}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: .5,
              color: ColorConstants.primary_black.withOpacity(.3),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "₹  " + "${data?.grandTotal.toInt()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
