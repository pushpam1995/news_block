import 'dart:async';
import 'package:news_block_implementation/models/top_headline_response_model.dart';
import 'package:news_block_implementation/services/news_list_get.dart';

enum ConstantValue{
  fetch,

}

class NewsBloc {
  final stateStreamController = StreamController<List<Article>?>();

  StreamSink<List<Article>?> get _streamSink => stateStreamController.sink;

  Stream<List<Article>?> get stream => stateStreamController.stream;

  final eventStreamController = StreamController<ConstantValue>();

  StreamSink<ConstantValue> get eventStreamSink => eventStreamController.sink;

  Stream<ConstantValue> get _eventStream => eventStreamController.stream;
  NewsBloc(){
    _eventStream.listen((event) async{
      if(event==ConstantValue.fetch)
        {
          try{
            var res = await ApiManager().fetchAlbum();
            _streamSink.add(res.articles);
          } on Exception catch(excep){
            _streamSink.addError("went worng");
          }

        }
    });
  }

}
