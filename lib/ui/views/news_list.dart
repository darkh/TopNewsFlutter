import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/ui/views/news_details_page.dart';
import 'package:newsapp/ui/widgets/widgets.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      switch (state.status) {
        case NewsStatus.failure:
          return Center(child: Text(S.of(context).failedToFetchNews));
        case NewsStatus.success:
          if (state.news.isEmpty) {
            return Center(child: Text(S.of(context).noNews));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.news.length
                  ? const Loader()
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return NewsDetailsPage(
                                articles: state.news[index],
                              );
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return Align(
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: NewsListItem(articles: state.news[index]));
            },
            itemCount:
                state.hasReachedMax ? state.news.length : state.news.length + 1,
            controller: _scrollController,
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NewsBloc>().add(FetchNews());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
