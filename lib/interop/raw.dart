
@JS('lf.raw')
library interop.lf.raw;

import 'package:js/js.dart';
import 'schema.dart' show Row;
import 'promise.dart';

// 1. dynamics were `any` in ts.d
// 2. Made Promise<void> instead of Promise<Null>
@JS()
abstract class BackStore {
  external dynamic getRawDBInstance();
  external dynamic getRawTransaction();

  external Promise<Null> dropTable(String tableName);
  external Promise<Null> addTableColumn(String tableName, String columnName, dynamic /*string|boolean|number|Date|ArrayBuffer*/ defaultValue);
  external Promise<Null> dropTableColumn(String tableName, String columnName);
  external Promise<Null> renameTableColumn(String tableName, String oldColumnName, String newColumnName);

  external Row createRow(Object payload);
  external int getVersion(); // Maybe it should be `num`, dunno... ts.d said `number`.
  external List<Object> dump();
}