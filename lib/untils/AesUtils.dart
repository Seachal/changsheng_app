import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart';

import 'SPClassConstants.dart';

class AesUtils {
  /**
   * 加密
   */
  static String encryptAes(String content,
      {AESMode aesMode = AESMode.cbc,}) {
    final iv = IV.fromLength(16);
    final _aesKey = Key.fromUtf8(SPClassConstants.spProEncryptKey);
    final _encrypter = Encrypter(AES(_aesKey, mode: aesMode));
    final _encrypted = _encrypter.encrypt(content,iv: iv);
    return _encrypted.base64;
  }

  /**
   * 解密
   */
  static String decryptAes(String content,
      {AESMode aesMode = AESMode.cbc,}) {
    final iv = IV.fromLength(16);
    var _res = convert.base64.decode(content);
    final _aesKey = Key.fromUtf8(SPClassConstants.spProEncryptKey);
    final _encrypter =
    Encrypter(AES(_aesKey, mode: aesMode));
    final _decrypted = _encrypter.decrypt(Encrypted(_res),iv: iv);
    return _decrypted;
  }
}
