import 'dart:io';

import 'package:path_provider/path_provider.dart';

/**
 * Created by YHF at 17:43 on 2021-10-19.
 */

class FileOperate{
  void test()async{
    Directory? directory = await getTemporaryDirectory();//获取应用缓存目录
    directory = await getApplicationDocumentsDirectory();//应用程序目录,只有自己可以访问
    directory = await getExternalStorageDirectory();//获取外部存储目录

  }
}