import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_serve/my_content_type.dart';
import 'package:shelf/shelf.dart' as shelf;

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main(List<String> args) async {
//  var parser = ArgParser()..addOption('port', abbr: 'p');
//  var result = parser.parse(args);
//  // For Google Cloud Run, we respect the PORT environment variable
//  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
//  var port = int.tryParse(portStr);
//  if (port == null) {
//    stdout.writeln('Could not parse port value "$portStr" into a number.');
//    // 64: command line usage error
//    exitCode = 64;
//    return;
//  }
//  var handler = const shelf.Pipeline()
//      .addMiddleware(shelf.logRequests())
//      .addHandler(_echoRequest);
//  var server = await io.serve(handler, _hostname, port);
//
//  var databaseModel = DatabaseModel(_hostname, 'root', 'Chen@1995', 'best');
//
//  var sqlResult = await databaseModel.query('select * from users');
//  //查询数据
//  sqlResult.forEach((row) {
//    var map = row.asMap();
//    print('${row.fields}');
//    map.forEach((key, val) {
//      print('key:${key},value:${val}');
//    });
//  });
//  await databaseModel.query('select * from users');
//  await databaseModel.close();
////
//  var input =
//      Runes('\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
//  print(String.fromCharCodes(input));
//
  final script = File(Platform.script.toFilePath());
  await runServer('${script.parent.path}${Platform.pathSeparator}static');
}

shelf.Response _echoRequest(shelf.Request request) {
  return onHandler(request);
}

shelf.Response onHandler(shelf.Request request) {
//  if (request.method == 'GET') {
//    //注册路由
//  } else if (request.method == 'PSOT') {
//    return shelf.Response.ok('Request PSOT:for headers:"${request.headers}"');
//  }
}

Future<void> runServer(String basePath) async {
  final server = await HttpServer.bind('127.0.0.1', 9000);
  print('Serving at http://${server.address.host}:${server.port}');
  await for (HttpRequest request in server) {
    await handleRequest(basePath, request);
  }
}

Future<void> handleRequest(String basePath, HttpRequest request) async {
  try {
    final path = request.uri.toFilePath();
    // PENDING: Do more security checks here.
    final resultPath = path == '${Platform.pathSeparator}' ? '${Platform.pathSeparator}index.html' : path;
    print(path);

    final contentType = request.headers.contentType;
    var method = request.method;
//  print('请求内容长度：${request.contentLength}');
//  print('当前路径:$resultPath');
    final file = File('$basePath$resultPath');
    var less = resultPath.substring(
        resultPath.lastIndexOf('.') + 1, resultPath.length);
    //有限匹配路由：正则匹配：控制器匹配
    print(file.path);
    print(
        '请求URL:${method} =====>${resultPath}${contentType != null ? '\t===>请求类型ContentType:${contentType}' : ''}');
    if (await file.exists()) {
      try {
        var response = request.response;
        response.statusCode = HttpStatus.ok;
        if (less == 'html') {
          response.headers.contentType = ContentType.html;
        } else if (less == 'css') {
          response.headers.contentType = NewContentType.stream;
        } else if (less == 'js') {
          response.headers.contentType = NewContentType.js;
        }
        await response.addStream(file.openRead());
        await response.close();
      } catch (exception) {
        await sendInternalError(request.response);
      }
    } else {
      var buffer = StringBuffer();
      if (resultPath == '${Platform.pathSeparator}getJson') {
        request.listen((data) {
          data.forEach((ele) {
            buffer.write(String.fromCharCode(ele));
          });
        }, onDone: () {
          print(buffer.toString());
        }, onError: (e) {
          sendInternalError(request.response);
        });
        await request.response.close();
      } else {
        await sendNotFound(request.response);
      }
    }
  } catch (e) {
//    print(e);
    await sendInternalError(request.response);
  }
}

Future<void> sendInternalError(HttpResponse response) async {
  response.statusCode = HttpStatus.internalServerError;
  await response.close();
}

Future<void> sendNotFound(HttpResponse response) async {
  var html404 = '''
  <html>
  <meta charset='UTF-8'/>
  <title>当前页面不存在</title>
  <body>
  <p>404 not found</p>
  <p>当前页面不存：检查URL是否正确:${DateTime.now()}</p>
  <div>
  <p><span>handler:</span></p>
  <p>${response.headers}</p>
  </div>
  </body>
  </html>
  ''';
  try {
    response
      ..headers.contentType = ContentType.html
      ..statusCode = HttpStatus.notFound
      ..write(html404);
  } on Exception catch (e, s) {
    response.addError(e, s);
    print(s);
  }
  await response.close();
}
