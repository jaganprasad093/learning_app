import 'package:flutter/material.dart';
import 'package:learning_app/controller/notification_controller/notificationsScreenController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  void initState() {
    context.read<Notificationsscreencontroller>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<Notificationsscreencontroller>();
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.notificationModel?.data?[index]
                                          .subIdentifier ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  provider.notificationModel?.data?[index]
                                          .messageTitle ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  provider.notificationModel?.data?[index]
                                          .createdAt ??
                                      "",
                                  style: TextStyle(
                                      color: ColorConstants.primary_black
                                          .withOpacity(.4)),
                                ),
                              ],
                            ),
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
          itemCount: provider.notificationModel?.data?.length ?? 0),
    );
  }
}
