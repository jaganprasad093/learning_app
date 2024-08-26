import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/view/checkout_page/widgets/course_card.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better layout
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
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
                    text: "₹ 399 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "₹ 1999",
                    style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: "  73% off",
                    style: TextStyle(
                      color:
                          Colors.black, // Optional: Change color for emphasis
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "1 Course in Cart",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => CourseCard(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: 10),
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
    );
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
                  SizedBox(
                      height: 16), // Add some space before the payment method
                  Text(
                    "Select a payment method:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
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
