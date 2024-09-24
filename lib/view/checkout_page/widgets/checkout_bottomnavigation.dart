import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/cart_controller/CartController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class checkout {
  TextEditingController couponController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedOption = 0;
  List paymentTypes = [
    "Gpay",
    "Credit card",
    "Debit card",
    "Net banking",
    "Paypal"
  ];
  List paymentTypes1 = ["gpay", "card", "debit_card", "netbanking", "paypal"];
  bool isApply = false;
  showBottomsheet(BuildContext context, int totalPrice) {
    // context.read<Cartcontroller>().checkout(paymentTypes1[0]);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<Cartcontroller>(
                  builder: (context, provider, child) {
                    log("rebuild =======================================================");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
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
                              "$totalPrice",
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
                            isApply == false
                                ? Text(
                                    "₹ " + "0",
                                  )
                                : Text(
                                    "-₹" +
                                        "${provider.checkOutModel?.discountAmount.toInt() ?? 0}",
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                            color:
                                ColorConstants.primary_black.withOpacity(.5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            isApply == false
                                ? Text(
                                    "₹ " + "$totalPrice",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "₹ " +
                                        "${provider.checkOutModel?.grandTotal ?? totalPrice}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                                  onChanged: (value) {
                                    isApply = false;
                                    provider.error_message = null;
                                  },
                                  controller: couponController,
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      hintText: 'Coupon Code',
                                      contentPadding: EdgeInsets.all(8),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorText: provider.error_message),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter the coupon code';
                                    }
                                  }),
                            ),
                            InkWell(
                              onTap: () {
                                if (isApply == false) {
                                  if (_formKey.currentState!.validate()) {
                                    provider.applyPromo(couponController.text);

                                    log("coupon code---${couponController.text}");
                                    setState(() {
                                      isApply = true;
                                    });
                                  }
                                } else {
                                  couponController.clear();
                                  // value.checkOutModel = null;
                                  log("text editing controller---${couponController.text}");
                                  setState(() {
                                    isApply = false;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isApply &&
                                          couponController.text.isNotEmpty
                                      ? Colors.transparent
                                      : ColorConstants.button_color,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Center(
                                  child: isApply &&
                                          couponController.text.isNotEmpty
                                      ? Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: ColorConstants.button_color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 0),
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
                            log("selected option ${paymentTypes[selectedOption]}");

                            provider.checkout(paymentTypes[selectedOption]);
                            Navigator.pushReplacementNamed(context, "/confrim");
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
