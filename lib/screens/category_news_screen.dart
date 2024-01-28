import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/show_category_model.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/show_category_news.dart';

class CategoryNewsScreen extends StatefulWidget {
  static const routeName = 'category_news_screen';
  String categoryName;
  CategoryNewsScreen({required this.categoryName, super.key});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  List<ShowCategoryModel> categories = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoryNews(widget.categoryName.toLowerCase());
    categories = showCategoryNews.categories;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ShowCategory(
                  // url: articles[index].url!,
                  title: categories[index].title!,
                  image: categories[index].urlToImage!,
                  description: categories[index].description!);
            }),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String title, image, description;
  ShowCategory(
      {required this.title,
      required this.description,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
