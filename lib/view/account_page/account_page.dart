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
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "",
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
            SizedBox(height: 20),
            Container(
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Wishlist",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
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
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
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
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.policy),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
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
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.book_online_rounded),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
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
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.settings),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {},
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red),
                        ),
                      ],
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
