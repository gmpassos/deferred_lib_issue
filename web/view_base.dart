import 'dart:async';
import 'dart:html';

import 'view_deferred.dart' deferred as view_deferred;

abstract class ViewBase {
  FutureOr<Element> build();

  bool get isBuilt => _content != null;

  Element? _content;

  FutureOr<Element> content() {
    var content = _content;
    if (content != null) return content;

    var build = this.build();
    if (build is Future<Element>) {
      return build.then((c) => _content = c);
    } else {
      return _content = build;
    }
  }

  FutureOr<bool> refresh() {
    var prevContent = _content;
    if (prevContent == null) return false;

    var parent = prevContent.parent;
    if (parent == null) return false;

    var idx = parent.children.indexOf(prevContent);
    if (idx < 0) return false;

    prevContent.remove();

    var build = this.build();

    if (build is Future<Element>) {
      return build.then((c) {
        _content = c;
        parent.children.insert(idx, c);
        return true;
      });
    } else {
      _content = build;
      parent.children.insert(idx, build);
      return true;
    }
  }
}

class MainView extends ViewBase {
  MainView() {
    window.onHashChange.listen((_) => refresh());
  }

  String get hash => window.location.hash;

  bool get showExtra => hash.contains("extra");

  String? _builtHash;

  String? get builtHash => _builtHash;

  @override
  FutureOr<Element> build() {
    var div = DivElement()
      ..innerHtml = '<br><br><br><br>\n'
          'HASH: $hash\n'
          '<hr>\n'
          '[ MAIN VIEW ]<br>\n'
          'Hello World!<br>\n'
          '<hr>\n';

    div.children.add(ButtonElement()
      ..text = 'Empty hash'
      ..onClick.listen((_) {
        window.location.hash = '';
      }));

    div.children.add(ButtonElement()
      ..text = 'Hash: foo'
      ..onClick.listen((_) {
        window.location.hash = 'foo';
      }));

    div.children.add(ButtonElement()
      ..text = 'Hash: extra'
      ..onClick.listen((_) {
        window.location.hash = 'extra';
      }));

    if (showExtra) {
      div.children.add(HRElement());

      return view_deferred.loadLibrary().then((_) {
        div.children.add(view_deferred.ViewExtra().content());
        return div;
      });
    }

    _builtHash = hash;

    return div;
  }
}
