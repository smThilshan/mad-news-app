import 'package:flutter/material.dart';
import 'package:news_app/screens/category_news_screen.dart';

import '../models/category_model.dart';

class CategorySlider extends StatelessWidget {
  final List<CategoryModel> categories;

  CategorySlider(this.categories);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: 5,
      ),
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {
              // print("Category ${categories[index]?.categoryName} selected");-
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryNewsScreen(
                          categoryName:
                              categories[index].categoryName ?? "general")));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index]?.categoryName ?? "entertainment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
