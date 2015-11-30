
@JS('lf.fn')
library interop.lf.fn;

import 'package:js/js.dart';
import 'schema.dart' as schema;

external schema.Column avg(schema.Column column);
external schema.Column count([schema.Column column]);
external schema.Column distinct(schema.Column column);
external schema.Column geomean(schema.Column column);
external schema.Column max(schema.Column column);
external schema.Column min(schema.Column column);
external schema.Column stddev(schema.Column column);
external schema.Column sum(schema.Column column);
