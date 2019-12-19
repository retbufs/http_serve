library serve.database;

import 'dart:async';
import 'package:mysql1/mysql1.dart' as mysql;

class DatabaseModel {
  final String name;
  final String host;
  final String dbname;
  final String pass;
  mysql.MySqlConnection _connection;

  factory DatabaseModel(
      [String host, String name, String pass, String dbname]) {
    return DatabaseModel._newInBaseModel(host, name, pass, dbname);
  }

  DatabaseModel._newInBaseModel(this.host, this.name, this.pass, this.dbname) {
    _createConnection().then((conn) {
      _connection = conn;
    });
  }

  //创建数据库连接
  Future<mysql.MySqlConnection> _createConnection() async {
    var conn = await mysql.MySqlConnection.connect(mysql.ConnectionSettings(
        user: name, password: pass, useSSL: false, port: 3306, db: dbname));
    print(conn.runtimeType);
    return conn;
  }

  Future<mysql.Results> query(String sql) async {
    var conn = await _createConnection();
    var melts = await conn.query(sql);
    //查询完成之后释放msyql
    await conn.close();
    return melts;
  }
  //关闭库连接
  void close() async {
    await _connection.close();
  }

}
