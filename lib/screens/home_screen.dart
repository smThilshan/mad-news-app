import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/screens/article_view_screen.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/widgets/category_slider_widget.dart';
import 'package:news_app/widgets/my_icon_button.dart';
import 'package:news_app/widgets/news_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CategorySlider(categories),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyIconButton(
              btnIcon: Icon(Icons.search),
              btnText: "Search ",
              onClick: () {},
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return NewsWidget(
                      url: articles[index].url!,
                      title: articles[index].title!,
                      imageUrl: articles[index].urlToImage!,
                      description: articles[index].description!);
                }),
          ),
        ],
      ),
    );
  }
}
