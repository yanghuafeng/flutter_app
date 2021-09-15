import 'package:fluro/fluro.dart';
import 'package:flutterapp/ProviderNotes/ConsumerTest.dart';
import 'package:flutterapp/ProviderNotes/ProviderTest.dart';
import 'package:flutterapp/ProviderNotes/ValueListener.dart';
import 'package:flutterapp/ProviderNotes/WholeProviderTest.dart';

import 'IRouterProvider.dart';

/**
 * Created by YHF at 16:02 on 2021-09-15.
 */

class ProviderRouter extends IRouterProvider{

  static String consumerTest = "/provider/consumerTest";
  static String valueProvider = "/provider/valueProvider";
  static String providerTest = "/provider/providerTest";
  static String wholeProvider = "/provider/wholeProvider";



  @override
  void initRouter(FluroRouter router){
    router.define(consumerTest, handler: Handler(handlerFunc: (_,params){
      return ConsumerTest();
    }));
    router.define(valueProvider, handler: Handler(handlerFunc: (_,params){
      return ValueListener();
    }));
    router.define(providerTest, handler: Handler(handlerFunc: (_,params){
      return ProviderTest();
    }));
    router.define(wholeProvider, handler: Handler(handlerFunc: (_,params){
      String dataId = "0";
      if (params.containsKey("dataId")) {
        dataId = params["dataId"]!.first;
      }
      return WholeProviderTest(int.parse(dataId));
    }));
  }
}