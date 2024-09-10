import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.button_color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.primary_white,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                ColorConstants.button_color.withOpacity(.2),
                            radius: 25,
                            child: Icon(
                              Icons.notification_important,
                              color: ColorConstants.primary_black,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Registered Sucessfully",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text("1 min ago"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 15,
              ),
          itemCount: 5),
    );
  }
}
