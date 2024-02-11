import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:toasties_flutter/common/constants/env4toasties.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsAPIServices {
  NewsAPIServices._();

  static late final NewsAPI newsAPI;

  static void init() {
    newsAPI = NewsAPI(ToastiesEnv.newsApiKey);
  }

  // static Future<void> getTopHeadlines() async {
  //   await NewsAPI.topHeadlines();
  // }

  static Widget buildEverythingTabView() {
    return FutureBuilder<List<Article>>(
      future: newsAPI.getEverything(query: "bitcoin"),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? _buildArticleListView(snapshot.data!)
                : _buildError(snapshot.error as ApiError)
            : _buildProgress();
      },
    );
  }

  static Widget _buildProgress() {
    return Center(child: CircularProgressIndicator());
  }

  static Widget _buildError(ApiError error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.code ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(error.message!, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  static ListTile buildArticleTile(BuildContext context, Article article) {
    return ListTile(
      // navigate to the article's url
      onTap: () async => await launchUrl(Uri.parse(article.url!)),
      contentPadding:
          const EdgeInsets.only(left: 10, right: 5, top: 0, bottom: 0),
      title: Text(
        article.title!,
        maxLines: 2,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      // subtitle: Text(article.description ?? "", maxLines: 1),
      trailing: AspectRatio(
        aspectRatio: 2.0,
        child: article.urlToImage == null
            ? null
            : Image.network(article.urlToImage!, fit: BoxFit.cover),
      ),
    );
  }

  static Widget _buildArticleListView(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        Article article = articles[index];
        // print('article: ${article.title}, ${article.url}');
        return Card(
          child: buildArticleTile(context, article),
        );
      },
    );
  }
}
