import 'package:grpc/grpc.dart' as rpc;
import 'package:http_serve/generated/helloworld.pbgrpc.dart';




class GreeterServer extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(rpc.ServiceCall call, HelloRequest request) async {
    return HelloReply()..message = 'build, ${request.name}!';
  }
}

Future<void> main() async {
  final server = rpc.Server([GreeterServer()]);
  await server.serve(port: 50051);
}