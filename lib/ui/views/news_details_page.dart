import 'package:flutter/material.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/models/models.dart';

class NewsDetailsPage extends StatelessWidget {
  final Articles articles;
  const NewsDetailsPage({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).news_details)),
        body: Column(
          children: [
            Hero(
              tag: articles.title,
              child: Image.network(articles.urlToImage,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: const Center(child: Text('No Image')),
                      ),
                  fit: BoxFit.fill),
            ),
            Text(articles.title),
            const SizedBox(
              height: 20,
            ),
            Text(articles.description)
          ],
        ));
  }
}
