import 'dart:html';

import 'view_base.dart';

class ViewExtra extends ViewBase {
  @override
  Element content() => super.content() as Element;

  @override
  Element build() {
    return DivElement()
      ..style.backgroundColor = '#666666'
      ..style.color = '#ffffff'
      ..style.padding = '4px'
      ..innerHtml = 'EXTRA VIEW ACTIVE';
  }
}
