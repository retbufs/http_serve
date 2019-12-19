import 'dart:io';

class NewContentType {
  //application/x-img
  static final img = ContentType('application', 'x-img', charset: 'utf-8');

  //application/x-javascript
  static final js =
      ContentType('application', 'x-javascript', charset: 'utf-8');

  //完整开始
  static final stream =
      ContentType('application', 'octet-stream', charset: 'utf-8');
  static final x001 = ContentType('application', 'x-001', charset: 'utf-8');
  static final h323 = ContentType('text', 'h323', charset: 'utf-8');
  static final d907 = ContentType('drawing', '907', charset: 'utf-8');
  static final acp = ContentType('audio', 'x-mei-aac', charset: 'utf-8');
  static final aif = ContentType('audio', 'aif', charset: 'utf-8');
  static final aiff = ContentType('audio', 'aiff', charset: 'utf-8');
  static final asa = ContentType('text', 'asa', charset: 'utf-8');
  static final asp = ContentType('text', 'asp', charset: 'utf-8');
  static final au = ContentType('audio', 'basic', charset: 'utf-8');
  static final awf =
      ContentType('application', 'vnd.adobe.workflow', charset: 'utf-8');
  static final bmp = ContentType('application', 'x-bmp', charset: 'utf-8');
  static final c4t = ContentType('application', 'x-c4t', charset: 'utf-8');
  static final cal = ContentType('application', 'x-cals', charset: 'utf-8');
  static final cdf = ContentType('application', 'x-netcdf', charset: 'utf-8');
}
