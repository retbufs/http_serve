import 'package:grpc/grpc.dart';
import 'package:http_serve/generated/helloworld.pbgrpc.dart';

Future<void> main(List<String> args) async {
  final chanel = ClientChannel('localhost',
      port: 50051,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));
  final stub = GreeterClient(chanel);
  final name = args.isNotEmpty ? args[0] : 'world';
  try {
    final respone = await stub.sayHello(HelloRequest()..name = name);
    print(respone.toString());
    print('Greeter clien received:${respone.message}');
  } catch (e) {
    print('Caught error :${e}');
  }
  await chanel.shutdown();
}
