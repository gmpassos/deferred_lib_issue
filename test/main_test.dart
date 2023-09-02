@TestOn('chrome')
import 'dart:html';

import 'package:test/test.dart';

import '../web/view_base.dart';

void main() {
  test('View Test', () async {
    var documentElement = window.document.documentElement!;

    var mainView = MainView();

    expect(mainView.isBuilt, isFalse);
    expect(mainView.builtHash, isNull);

    documentElement.children.add(await mainView.content());

    expect(mainView.builtHash, isNotNull);

    // This change works.
    await setLocationHash('foo');
    expect(mainView.builtHash, equals('#foo'));
    expect(documentElement.text, contains('HASH: #foo'));

    // This change crashes, since it will call
    // `view_deferred.loadLibrary()`
    await setLocationHash('extra');
    expect(mainView.builtHash, equals('#extra'));
    expect(documentElement.text, contains('HASH: #extra'));
  });
}

Future<void> setLocationHash(String hash) async {
  window.location.hash = hash;
  await Future.delayed(Duration(milliseconds: 300));
}
