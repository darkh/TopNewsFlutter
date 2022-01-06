import 'package:flutter/material.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/models/models.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({Key? key, required this.articles}) : super(key: key);

  final Articles articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Hero(
            tag: articles.title,
            child: Image.network(articles.urlToImage,
                width: 80,
                height: 80,
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
                      width: 80,
                      height: 80,
                      child: Center(child: Text(S.of(context).noImage)),
                    ),
                fit: BoxFit.fill),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(articles.title),
          ))
        ],
      ),
    );
  }
}
