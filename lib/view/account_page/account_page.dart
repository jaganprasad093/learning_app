import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            Center(
              child: Stack(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/34534/people-peoples-homeless-male.jpg?auto=compress&cs=tinysrgb&w=600",
                  ),
                  radius: 60,
                  // backgroundColor: Colors.grey.withOpacity(0.6),
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    )),
              ]),
            ),
            SizedBox(height: 10),

            Text(
              "Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("e-mail"),
            SizedBox(height: 40),

            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/editprofile");
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Wishlist",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Orders",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "About app",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Delete account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Container(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConstants.button_color),
                    ),
                  ),
                ),
              ],
            )
            // Additional content can go here
          ],
        ),
      ),
    );
  }
}
