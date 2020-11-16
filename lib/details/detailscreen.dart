import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/article.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                if (article.imageUrl != null)
                  Image.network(
                    article.imageUrl,
                    fit: BoxFit.cover,
                  ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          article.content,
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ))),
                RaisedButton(
                  child: Text("Read more"),
                  onPressed: () {
                    _openArticleUrl(article);
                  },
                )
              ],
            )));
  }

  void _openArticleUrl(Article article) async {
    if (await canLaunch(article.url)) {
      await launch(article.url);
    } else {
      throw 'Could not launch ${article.url}';
    }
  }
}
