import 'package:coronavirus/news_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  List<Widget> cards = List<Widget>();
  ScrollController _controller = ScrollController();
  RefreshController _refreshController = RefreshController();
  LoadingState loadingState;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      //debugPrint('fuck ${_controller.offset}, ${_controller.position.maxScrollExtent}');
      if (_controller.offset >= _controller.position.maxScrollExtent && loadingState != LoadingState.LOADING)
        addNews();
    });
    addNews();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void addNews() {
    if(loadingState == LoadingState.LOADING) return;
    debugPrint('called');
    setState(() {
      loadingState = LoadingState.LOADING;
    });
    Dio dio = Dio();

    //TODO send the date of the latest one and get ones on or after that date
    String url = 'https://corona.icanhelp.us/latest/${cards.length /* - 1 ? */ }';
    debugPrint("url: $url");
    dio.get(url).then((Response res) {
      if(res.data['success'] == true) {
        for(int i = 0; i < res.data['results'].length; i++) {
          try {
            // this is integral to funcitonality
            debugPrint('just got ${res.data['results'][i]['title']}');
          } catch(e) {
            if(cards.last is NewsCard) {
              cards.add(Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 72),
                child: Center(child: Text('there is no news before this point\n')),
              ));
            }
            _controller.jumpTo(_controller.offset - 1);
            continue;
          }
          cards.add(NewsCard(
            title: res.data['results'][i]['title'],
            url: res.data['results'][i]['url'],
            dateAdded: res.data['results'][i]['date'],
            id: res.data['results'][i]['id'],
          ));
        }
      }
      setState(() {
        loadingState = LoadingState.SUCCESS;
      });
//      _controller.animateTo(_controller.offset + 70, duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
      _refreshController.refreshCompleted();
    }, onError: (e){
      setState(() {
        loadingState = LoadingState.ERROR;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coronavirus news'),
        elevation: 0,
      ),
      body: loadingState == LoadingState.ERROR ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('error loading'),
            OutlineButton(
              child: Text('try again'),
              onPressed: () {
                addNews();
              },
            )
          ],
        ),
      ) : SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enableTwoLevel: true,
        onRefresh: () {
          cards = List<Widget>();
          addNews();
        },
        child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: cards.length + 1,
          itemBuilder: (ctx, index) {
            if(index == cards.length)
              return loadingState == LoadingState.LOADING ? Center(child: CircularProgressIndicator()) : Container();
            return cards[index];
          },
        ),
      ),
    );
  }
}


class NewsCard extends StatefulWidget {

  final String title, url, id, dateAdded;

  NewsCard({this.title, this.url, this.id, this.dateAdded});

  static NewsCard fromList(List<String> list) {
    return null; // todo
  }

  List<String> toList() {
    return null; // todo
  }

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        color: Colors.black87.withOpacity(0.95),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewsScreen(newsCard: widget)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text('${widget.title}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700), maxLines: 2),
                            flex: 6,
                          ),
                          Flexible(
                              child: Text('${widget.dateAdded}', style: TextStyle(color: Colors.white30, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),),
                              flex: 3
                          ),
                        ], // id for testing purposes, date for prod
                      ),
                      Text('${widget.url}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300), maxLines: 1,)
                    ],
                  ),
                ),
//          Flexible(
//            flex: 1,
//            child: Image.network(src),
//          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
