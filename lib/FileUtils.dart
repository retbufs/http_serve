import 'dart:convert';
import 'dart:io';
import 'dart:async';

///FileSystemEntity
/// 文件与目录都是实现自：FileSystemEntity
/// FileSystemEntity 具有一些静态的公共的方法：
///
class FileUtils {
  static const _filename = './static/streams.txt';
  static const _confname = './static/conf.yaml';

  //创建资源配置文件
  Future<void> createConf() async {
    try {
      var file = File(_confname);
      var directory = file.parent;
      print(directory.path);
      if (!(await directory.exists())) {
        await directory.create();
      }
      if (!(await file.exists())) {
        await file.create();
      }
      await file.writeAsString('appname= fios');
      //读取文件
      await file.readAsString().then((String contents) {
        print(contents);
      });
      //写入文件
    } catch (e) {
      print(e);
    }
  }

//更灵活和有用的读取文件的方法是使用Stream
  void fileRead() {
    var file = File(_confname);
    //Stream<List<int>>
    var inputStream = file.openRead();
    //读取文件流
    inputStream
    //转换编码格式
        .transform(utf8.decoder)
    //转换为单独的行
        .transform(LineSplitter())
    //处理结果的监听
        .listen((String line) {
      print('content:$line:字节长度:${line.length} bytes');
    }, onDone: () {
      print('file is now closed');
    }, onError: (e) {
      print(e.toString());
    });
  }

  //文件内容的写入
  void fileWriter() {
    var file = File(_filename);
    //写入字符串
    file.writeAsString('some content').then((file) {
      print('写入成功!');
    });
    //使用stream 流写入
    var myFile = File(_filename);
    var sink = file.openWrite();
    sink.write('FILE ACCESSS &(${DateTime.now()}\n)');
    //使用流写入文件需要对流进行关闭
    sink.close();
  }

  //为避免避免无意中阻止程序，使用Future的返回值的使用方式：
  //返回未来的方法：length， exists, lastModified, stat
  void fileFuture() {
    final file = File(_filename);
    file.length().then((len) {
      print('file is bytes len :${len}');
    });
    file.exists().then((has) {
      print('file is ${has}');
    });
    file.lastModified().then((lastTime) {
      print('last modify time${lastTime}');
    });
    file.lastAccessed().then((aecc) {
      print(aecc);
    });
  }

  //文件的基本属性
  void properties() {
    final file = File(_filename);
    print('文件所造位置的绝对路径：${file.absolute}');
    print('设置的文件路径：${file.path}');
    print('文件所在的父级目录文件：${file.parent}');
    print('uri:${file.uri}');
    print('是否设置的文件路径是否是绝对路径:${file.isAbsolute}');
  }

  //文件操作常用方法
  Future<void> fileMethod() async {
    //对不存在的文件进行创建
    final file = File('./static/oncreate.txt');
    //对于不存在
    //Failed assertion: line 105 pos 12: 'null': is not true.
    assert(await file.exists() == true);
    await file.create();

    ///创建函同步方法：dart中推荐使用：异步的，避免出现阻塞状态
    ///createSync
    ///
    //文件的拷贝
    await file.copy('./static/newstream.txt');
    final blockingShared = FileLock.exclusive;
    print('文件锁：${blockingShared}');
    Future<FileStat> stat() => FileStat.stat(file.path);
    //文件的属性
    await stat().then((stat) {
      print(stat.toString());
    });
  }

  //文件目录
  Future<void> directory() async {
    var myDir = Directory('./myDir');
    //创建目录
    await myDir.create();
    var file = File('./myDir/systemDir.txt');
    //列出目录所有的文件和目录
//    var systemTemp = Directory.systemTemp;
//    systemTemp
//        .list(recursive: true, followLinks: false)
//        .listen((FileSystemEntity entry) {
//      print(entry.path);
//      file.openWrite().write(entry.path);
//    });
//    file.openWrite(mode: FileMode.write, encoding: utf8);
    var files = File(Platform.script.toFilePath());
    print('${Platform.script.toFilePath()}');
    print('${Platform.script.path}');
    print('${await (files.readAsString(encoding: ascii))}');
  }

//压缩文件
//GZipCodec

  Future<void> onGzip() async {
    var myDir = Directory('./myDir');
    var gzip = GZipCodec();
    final file = File('./myDir/systemDir.txt');

  }
}
