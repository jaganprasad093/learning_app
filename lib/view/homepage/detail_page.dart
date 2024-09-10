import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/view/homepage/widgets/recommentions.dart';
import 'package:learning_app/view/search_screen/widgets/search_card.dart';

class DetailPage extends StatefulWidget {
  final String author_name;
  final String description;
  final String phone;
  final price;
  final String course_name;

  const DetailPage(
      {super.key,
      required this.author_name,
      required this.description,
      required this.phone,
      required this.price,
      required this.course_name});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  color: ColorConstants.button_color,
                  child: Image.network(
                    widget.phone,
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                  width: 350,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.course_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                widget.description,
                // overflow: TextOverflow.ellipsis,
                // maxLines: 2,
                style: TextStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Bestseller",
                  style: TextStyle(color: ColorConstants.primary_white),
                ),
              ),
              Text(
                "₹ " + "${widget.price}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Author-  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    widget.author_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ColorConstants.button_color),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 53,
                width: 203,
                decoration: BoxDecoration(
                    color: ColorConstants.button_color,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.primary_white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: ColorConstants.button_color,
                          ),
                          Text(
                            " Add to bag",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorConstants.button_color),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 170,
                // color: ColorConstants.button_color,
                child: Center(
                  child: Text(
                    "Add to wishlist",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: ColorConstants.button_color),
                  ),
                ),
              ),
              Text(
                "Recently viewed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10,
                  childAspectRatio: 1, // Adjusts the aspect ratio of each item
                  crossAxisSpacing: 5, // Space between columns
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SearchCard();
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Recommentions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => RecommentionsCard(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 5),
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
