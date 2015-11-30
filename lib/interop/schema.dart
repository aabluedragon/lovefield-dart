
@JS('lf.schema')
library interop.lf.schema;

import 'package:js/js.dart';
import 'raw.dart' show BackStore;
import 'promise.dart' show Promise;
import 'lf.dart' as lf;

@JS('create')
class SchemaBuilder {
  external SchemaBuilder(String dbName, int dbVersion);

  external Promise<lf.Database> connect([ConnectOptions options]);
  external TableBuilder createTable(String tableName);
  external DatabaseInfo getSchema();
  external dynamic setPragma(DatabasePragma pragma); // in d.ts it returned `void` but interop throws error if it's `void` so I put dynamic, god knows (lovefield dev[s]) what it returns.
}

@JS()
abstract class TableBuilder {
  external TableBuilder addColumn(String name, int /*lf.Type*/ type);
  external TableBuilder addForeignKey(String name, RawForeignKeySpec spec);
  external TableBuilder addIndex(String name, /*Array<string>|Array<IndexedColumn>*/columns, [bool unique, int /*Order*/ order]);
  external TableBuilder addNullable(List<String> columns);
  external TableBuilder addPrimaryKey(/*Array<string>|Array<IndexedColumn>*/columns, [bool autoInc]);
  external TableBuilder addUnique(String name, List<String> columns);
}

@JS()
abstract class Row {} // Dunno, it was empty in d.ts

@JS()
abstract class Table {
  external Table as(String name);
  external Row createRow(Object value); // Weird, it was Object in d.ts too
  external String getName();
}

@JS()
abstract class DatabaseInfo {
  external String name();
  external DatabasePragma pragma();
  external List<Table> tables();
  external Table table(String tableName);
  external int version();
}

@JS()
@anonymous
class DatabasePragma {
  external bool get enableBundledMode;
  external factory DatabasePragma({bool enableBundledMode});
}

@JS()
@anonymous
class RawForeignKeySpec {
  external String get local;
  external String get ref;
  external int /*lf.ConstraintAction*/ get action;
  external int /*lf.ConstraintAction*/ get timing;

  external factory RawForeignKeySpec({String local, String ref, int /*lf.ConstraintAction*/ action, int /*lf.ConstraintAction*/ timing});
}

@JS()
@anonymous
class IndexedColumn {
  external bool get autoIncrement;
  external String get name;
  external int /*Order*/ get order;

  external factory IndexedColumn({bool autoIncrement, String name, int /*Order*/ order});
}


typedef Promise<Null> OnUpgradeCallback(BackStore rawDb);

@JS()
@anonymous
class ConnectOptions {

  external OnUpgradeCallback get onUpgrade;
  external int /*DataStoreType*/ get storeType;

// did not find such a propery name `webSqlDbSize` in the real lovefield js lib. (ts.d entry is `webSqlDbSize?: number`)
// ts.d comment: TODO(dpapad): firebase?

  external factory ConnectOptions({OnUpgradeCallback onUpgrade, int /*DataStoreType*/ storeType});
}

@JS()
abstract class Column extends lf.PredicateProvider {
  external Column as(String name);
  external String getName();
  external String getNormalizedName();
}