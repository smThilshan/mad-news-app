import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;
  ArticleView({required this.blogUrl, super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.disabled);
    controller
        .loadRequest(Uri.parse(widget.blogUrl)); // Access blogUrl from widget
  }

  // ..setJavaScriptMode(JavaScriptMode.disabled)
  // ..loadRequest(Uri.parse(blogUrl));

  @override
  Widget build(BuildContext context) {
    return Container(child: WebViewWidget(controller: controller));
  }
}
