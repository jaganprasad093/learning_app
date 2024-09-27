import 'package:flutter/material.dart';
import 'package:learning_app/controller/review_controller/ReviewController.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController report_controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Text(
              "Write your experice",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: report_controller,
              hintText: "Add report",
              maxLines: 4,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "Submit",
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final email = prefs.getString("email") ?? "";
                context
                    .read<Reviewcontroller>()
                    .addReport(email, report_controller.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
