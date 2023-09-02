import 'dart:html';

import 'view_base.dart';

void main() async {
  var output = querySelector('#output');
  output?.children.add(await MainView().content());
}
