# deferred_lib_issue

When `dart2js` is used by the package [test][pkg_test_github] it's not
able to serve the `...part.js` file.

You can reproduce the bug running the test of this repository:
```shell
dart test -p chrome
```

Error:
```text
...

00:08 +0 -1: test/main_test.dart: View Test [E]                                                                                                                                                       
  DeferredLoadException: 'Loading http://localhost:50656/Sa1ttbh3Sd59FoFnteBXDihHx9rZDIUn/test/main_test.dart.browser_test.dart.js_1.part.js?dart2jsRetry=3 failed: Instance of 'Event'
  Context: js-failure-wrapper
  event log:
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"downloadFailure","l":"view_deferred","s":"http://localhost:50656/Sa1ttbh3Sd59FoFnteBXDihHx9rZDIUn/test/main_test.dart.browser_test.dart.js","i":13}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"download","l":"view_deferred","i":12}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"startLoad","l":"view_deferred","i":11}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"retry2","l":"view_deferred","i":10}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"download","l":"view_deferred","i":9}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"startLoad","l":"view_deferred","i":8}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"retry1","l":"view_deferred","i":7}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"download","l":"view_deferred","i":6}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"startLoad","l":"view_deferred","i":5}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"retry0","l":"view_deferred","i":4}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"download","l":"view_deferred","i":3}
  {"p":"main_test.dart.browser_test.dart.js_1.part.js","e":"startLoad","l":"view_deferred","i":2}
  {"p":"main","e":"beginPart","i":1}
  '

...
```

### Dart Version:
```shell
dart --version
```

```text
Dart SDK version: 3.1.0 (stable) (Tue Aug 15 21:33:36 2023 +0000) on "macos_x64"
```

------

The issue can be fixed at:

https://github.com/dart-lang/test/blob/master/pkgs/test/lib/src/runner/browser/platform.dart

[pkg_test_github]: https://github.com/dart-lang/test/blob/master/pkgs/test
