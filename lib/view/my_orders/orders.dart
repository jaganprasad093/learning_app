import 'package:flutter/material.dart';
import 'package:learning_app/controller/OrderController/OrderController.dart';
import 'package:learning_app/view/my_orders/widgets/custom_ordercard.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    context.read<Ordercontroller>().getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Ordercontroller>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemBuilder: (context, index) => CustomOrdercard(index: index),
          separatorBuilder: (context, index) => SizedBox(
                height: 40,
              ),
          itemCount: provider.orderModel?.data?.length ?? 0),
    );
  }
}
