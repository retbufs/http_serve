import 'dart:io';

//单一函数方法
typedef RequestHandler = Future<HttpResponse> Function(HttpRequest request);

class Utils {}
