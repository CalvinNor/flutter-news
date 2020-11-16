import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/routes/detailsroute.dart';
import 'package:http/http.dart' as http;

import '../../data/article.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Article>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchArticles();
  }

  Future<List<Article>> fetchArticles() async {
    const apiKey = "261be8777683436f844b0af5ab6b3b47";
    const country = "us";
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return new List.from(jsonDecode(response.body)['articles'])
          .map((e) => Article.fromJson(e))
          .toList();
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Stories'),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildArticlesScrolledList(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildArticlesScrolledList(List<Article> articles) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ...articles.map((article) => _buildArticleRow(article))
          ],
        ));
  }

  Widget _buildArticleRow(Article article) {
    return InkWell(
        onTap: () => _onArticleTapped(article),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
                child: Row(children: [
              if (article.imageUrl != null)
                Image.network(
                  article.imageUrl,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        article.title,
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )))
            ]))));
  }

  void _onArticleTapped(Article article) {
    Navigator.of(context).push(getArticleDetailsRoute(article));
  }
}
