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
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
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
                validator: (String? value) {
                  return (value == null || value.isEmpty)
                      ? 'Enter at least a charater'
                      : null;
                },
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                text: "Submit",
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final email = prefs.getString("email") ?? "";
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<Reviewcontroller>()
                        .addReport(email, report_controller.text, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
