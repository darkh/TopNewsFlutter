import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/local_cubit.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/client/news_api_client.dart';
import 'package:newsapp/ui/views/news_list.dart';
import 'package:newsapp/generated/l10n.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).top_news),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'English':
                  context.read<LocalCubit>().changeLang(context, 'en');
                  break;
                case 'Arabic':
                  context.read<LocalCubit>().changeLang(context, 'ar');
                  break;
              }
            },
            icon: const Icon(Icons.language),
            itemBuilder: (BuildContext context) {
              return {'English', 'Arabic'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) =>
            NewsBloc(httpClient: NewsApiClient(httpClient: http.Client()))
              ..add(FetchNews()),
        child: const NewsList(),
      ),
    );
  }
}
