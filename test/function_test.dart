/**
 * Created by YHF at 10:51 on 2021-09-22.
 */

import 'package:flutter_test/flutter_test.dart';

/// 也可以使用命令来运行 flutter test test/counter_test.dart

void main() {
  // 单一的测试
  group('group',(){
    test("测试test1", () {

      print('1');
      expect(5, 5);
    });

    test("测试test2", () {
      print('5');
      expect(4, 4);
    });
  });

}