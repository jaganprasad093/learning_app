import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/checkout_page/widgets/course_card.dart';
import 'package:learning_app/view/detail_page/detail_page.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    // context.read<Cartcontroller>().removeCartItems(5, 1);
    context.read<Cartcontroller>().getCart();
    // context.read<Cartcontroller>().AddCartItems(17, 8000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Cartcontroller>();
    int TotalAmount;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: provider.cartModel?.data?.grandTotal.toInt() == null ||
                provider.cartModel?.data?.grandTotal.toInt() == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Your cart is empty !")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              ColorConstants.button_color)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigation(initialIndex: 0),
                            ));
                      },
                      child: Text(
                        "Back to homescreen",
                        style: TextStyle(
                            color: ColorConstants.primary_white,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            : Consumer<Cartcontroller>(
                builder: (context, value, child) => provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Total: ",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "₹ " +
                                        "${provider.cartModel?.data?.grandTotal.toInt()} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // TextSpan(
                                  //   text: "₹ 1999",
                                  //   style: TextStyle(
                                  //     color: Colors.black.withOpacity(.4),
                                  //     decoration: TextDecoration.lineThrough,
                                  //   ),
                                  // ),
                                  // TextSpan(
                                  //   text: "  73% off",
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "${provider.cartModel?.data?.cartItem?.length}" +
                                  " Course in Cart",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: provider.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        var data = value
                                            .cartModel?.data?.cartItem?[index];
                                        var auther_name = data?.autherName;
                                        var course_name = data?.courseName;
                                        var photo = data?.courseImage;

                                        var courseId =
                                            data?.courseId.toString();
                                        var variantID =
                                            data?.section?.id.toString();
                                        var selectedVarient =
                                            data?.section?.name;
                                        var price = data?.price.toInt();
                                        int variantPercent;
                                        variantPercent = data
                                                ?.section?.amountPerc
                                                ?.toInt() ??
                                            0;
                                        var disAmount =
                                            ((variantPercent / 100) * price)
                                                .toInt();
                                        TotalAmount = price - disAmount;
                                        log("discount amount---$TotalAmount");
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          id: data?.courseId ??
                                                              0),
                                                ));
                                            log("course id in detailpage--${data?.courseId ?? 0}");
                                          },
                                          child: CourseCard(
                                            TotalAmount: TotalAmount.toString(),
                                            auther_name: auther_name ?? "",
                                            course_name: course_name ?? "",
                                            photo: photo ?? "",
                                            price: price.toString(),
                                            courseID: courseId ?? "",
                                            variantID: variantID ?? "",
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 20,
                                          ),
                                      itemCount: value.cartModel?.data?.cartItem
                                              ?.length ??
                                          0),
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              text: "Complete Checkout",
                              onTap: () {
                                showpayment();
                              },
                            ),
                          ],
                        ),
                      ),
              ));
  }

  void showpayment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Summary",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Original Price",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "₹699",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "-₹1699",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(color: ColorConstants.primary_black.withOpacity(.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹ 699",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Coupon Code',
                            contentPadding: EdgeInsets.all(8),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: ColorConstants.button_color,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Select a payment method:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: paymentTypes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          paymentTypes[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio<int>(
                          value: index,
                          groupValue: selectedOption,
                          activeColor: ColorConstants.button_color,
                          splashRadius: 20,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value!;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    text: "Checkout",
                    onTap: () {
                      Navigator.pushNamed(context, "/otp");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int selectedOption = 0;
  List paymentTypes = ["Gpay", "Credit card", "Debit card", "Net banking"];
}
