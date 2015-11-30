
@JS('lf.op')
library interop.lf.op;

import 'package:js/js.dart';
import 'lf.dart' show Predicate;


external Function get and; // TODO(alonam) varargs, ts.d was `...args: Predicate[]`
external Predicate not(Predicate operand);
external Function get or; // TODO(alonam) varargs, ts.d was `...args: Predicate[]`

