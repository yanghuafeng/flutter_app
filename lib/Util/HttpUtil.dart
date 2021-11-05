import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

/**
 * Created by YHF at 17:56 on 2021-10-19.
 */

class HttpUtil{
  HttpClient httpClient = HttpClient();



  void connect()async{



    Uri url = Uri(scheme: "https",host: "flutterchina.club",queryParameters: {
      "xx":"xx",
      "dd":"dd"
    });//Uri.parse("https://www.baidu.com")

    //该方法用于添加用户凭据,
    httpClient.addCredentials(url,
      "admin",
      HttpClientBasicCredentials("username","password"), //Basic认证凭据
       // HttpClientDigestCredentials("username","password") //Diges 认证凭据，flutter只支持这两种认证
    );

//    回调方式
//    httpClient.authenticate=(Uri url, String scheme, String realm) async{
//      if(url.host=="xx.com" && realm=="admin"){
//        httpClient.addCredentials(url,
//          "admin",
//          HttpClientBasicCredentials("username","pwd"),
//        );
//        return true;
//      }
//      return false;
//    };

    HttpClientRequest request = await httpClient.getUrl(url);
    request.headers.add("user-agent", "test");
    String info = "dfdf";
    request.add(utf8.encode(info));

    //连接
    HttpClientResponse response = await request.close();
    //读取响应内容
    String reinfo = await response.transform(utf8.decoder).join();

    //所有请求关闭
    httpClient.close();
  }

  void dioForDownload()async{
    Dio dio =  Dio();

    Response response;
    response = await dio.get("/test?id=12&name=wendu");
    //等同上行 response=await dio.get("/test",queryParameters:{"id":12,"name":"wendu"})
    print(response.data.toString());


    response=await dio.post("/test",data:{"id":12,"name":"wendu"});

    response=await dio.download("https://www.google.com/","Savepath");

  }

  /// Downloading by spiting as file in chunks分块下载
  Future downloadWithChunks(
      url,
      savePath, {
        ProgressCallback? onReceiveProgress,
      }) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var dio = Dio();
    var progress = <int>[];

    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink= f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {//206为支持分块下载
      total = int.parse(
          response.headers.value(HttpHeaders.contentRangeHeader)!.split("/").last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader)!);
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

  
}