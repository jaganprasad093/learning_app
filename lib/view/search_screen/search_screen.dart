import 'package:flutter/material.dart';
import 'package:learning_app/view/search_screen/widgets/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: search_controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Browse Courses",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1, // Adjusts the aspect ratio of each item
                  crossAxisSpacing: 10, // Space between columns
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SearchCard();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
