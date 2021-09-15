import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:news_block_implementation/business_logic.dart';
import 'package:news_block_implementation/models/top_headline_response_model.dart';
import 'package:news_block_implementation/services/news_list_get.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Future<TopHeadline>? _futureAlbum;
  final NewsBloc newsBloc=NewsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _futureAlbum = ApiManager().fetchAlbum();
    newsBloc.eventStreamSink.add(ConstantValue.fetch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Container(
        child:StreamBuilder<List<Article>?>(
          stream: newsBloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {
                return InkWell(onTap:(){
                  openBrowserTab(snapshot.data![index].url.toString());
                } ,
                  child: Card(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(snapshot.data![index].urlToImage.toString()),
                              fit: BoxFit.cover)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data![index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                      ),
                    ),
                  ),
                );
              });
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            return Center(child: const CircularProgressIndicator());
          },
        ),
        /*ListView.builder(itemBuilder: (context, index) {
          return Card(child: ListTile(),elevation: 1.0,);
        }),*/
      ),
    );
  }
  openBrowserTab(String ur) async {
    await FlutterWebBrowser.openWebPage(url: ur,);
  }
 /* FutureBuilder<TopHeadline> buildFutureBuilder() {
    return FutureBuilder<TopHeadline>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data!.articles!.length,itemBuilder: (context, index) {
            return InkWell(onTap:(){
              openBrowserTab(snapshot.data!.articles![index].url.toString());
            } ,
              child: Card(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(snapshot.data!.articles![index].urlToImage.toString()),
                          fit: BoxFit.cover)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data!.articles![index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                  ),
                ),
              ),
            );
          });
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }*/
}
