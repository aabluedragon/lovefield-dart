
library lf.schema;

import 'interop/schema.dart' as interop_schema;
import 'interop/lf.dart' as interop_lf;
import 'interop/interop_wrapper.dart';
import 'lf.dart' as lf;
import 'dart:async';
import 'query.dart' as query;
import 'interop/promise.dart' show catchToCompleter;
import 'raw.dart' as raw;
import 'interop/raw.dart' as interop_raw;
import 'dart:js';
import 'orm.dart';

class SchemaBuilder extends InteropWrapper<interop_schema.SchemaBuilder> {

  LfOrm _orm;
  LfOrm get orm {
    return _orm;
  }

  SchemaBuilder(String dbName, int dbVersion, {orm:false, List<Type> entities}) {
    setWrappedInteropObject(new interop_schema.SchemaBuilder(dbName, dbVersion));
    if(orm) {
      _orm = new LfOrm(this, entities);
    }
  }

  Future<lf.Database> connect({OnUpgradeCallback onUpgrade, DataStoreType storeType}) async {
    Completer<lf.Database> completer = new Completer();

    interop_schema.ConnectOptions connectOptions;
    if(onUpgrade != null || storeType != null) {
      connectOptions = new interop_schema.ConnectOptions(onUpgrade:onUpgrade!=null?(interop_raw.BackStore rawDb){
        onUpgrade(new raw.BackStore(rawDb));
      }:null, storeType:storeType?.index);
    }

    return catchToCompleter(
      getWrappedInteropObject().connect(connectOptions).then((interop_lf.Database database) {
        lf.Database db = new lf.Database(database);
        completer.complete(db);
      })
    , completer);
  }

  TableBuilder createTable(String tableName)=>
      new TableBuilder(getWrappedInteropObject().createTable(tableName));
  DatabaseInfo getSchema()=>new DatabaseInfo(getWrappedInteropObject().getSchema());
  dynamic setPragma(interop_schema.DatabasePragma pragma)=>
      getWrappedInteropObject().setPragma(pragma);
}


class TableBuilder extends InteropWrapper<interop_schema.TableBuilder> {
  TableBuilder(interop_schema.TableBuilder interop) {
    setWrappedInteropObject(interop);
  }

  TableBuilder addColumn(String name, lf.ColumnType type)=>
      new TableBuilder(getWrappedInteropObject().addColumn(name, type.index));
  TableBuilder addForeignKey(String name, RawForeignKeySpec spec)=>
      new TableBuilder(getWrappedInteropObject().addForeignKey(name, spec._toInteropMap()));

  TableBuilder addIndex(String name, List<String> columns, [bool unique=null, query.Order order=null])=>
    new TableBuilder(getWrappedInteropObject().addIndex(name, columns, unique, order!=null?order.index:null));
  TableBuilder addIndexWithIndexedColumn(String name, List<IndexedColumn> columns, [bool unique=null, query.Order order=null]) {
    List<interop_schema.IndexedColumn> columnsInterop = columns.map((IndexedColumn col)=>col._toInteropMap()).toList();
    return new TableBuilder(getWrappedInteropObject().addIndex(name, columnsInterop, unique, order!=null?order.index:null));
  }

  TableBuilder addNullable(List<String> columns)=>
      new TableBuilder(getWrappedInteropObject().addNullable(columns));

  TableBuilder addPrimaryKey(List<String> columns, [bool autoInc = null])=>
    new TableBuilder(getWrappedInteropObject().addPrimaryKey(columns, autoInc));

  TableBuilder addPrimaryKeyIndexedColumn(List<IndexedColumn>columns, [bool autoInc = null]) {
    List<interop_schema.IndexedColumn> interopColumns = columns.map((IndexedColumn column)=>column._toInteropMap()).toList();
    return new TableBuilder(getWrappedInteropObject().addPrimaryKey(interopColumns, autoInc));
  }

  TableBuilder addUnique(String name, List<String> columns)=>
      new TableBuilder(getWrappedInteropObject().addUnique(name, columns));
}


class Person {

}
class Table extends InteropWrapper<interop_schema.Table> {

  // For queries
  lf.PredicateProvider v(String fieldName)=>
      new lf.PredicateProvider((getWrappedInteropObject() as JsObject)[fieldName]);

  Table(interop_schema.Table interop) {
    setWrappedInteropObject(interop);
  }
  Table as(String name)=>new Table(getWrappedInteropObject().as(name));
  interop_schema.Row createRow(Map value)=>getWrappedInteropObject().createRow(new JsObject.jsify(value));
  String getName()=>getWrappedInteropObject().getName();
}

class DatabaseInfo extends InteropWrapper<interop_schema.DatabaseInfo> {
  DatabaseInfo(interop_schema.DatabaseInfo interop) {
    setWrappedInteropObject(interop);
  }
  String name()=>getWrappedInteropObject().name();
  interop_schema.DatabasePragma pragma()=>getWrappedInteropObject().pragma();
  List<Table> tables() {
    List<Table> tables = getWrappedInteropObject().tables().map((interop_schema.Table table)=>new Table(table)).toList();
    return tables;
  }
  Table table(String tableName)=>new Table(getWrappedInteropObject().table(tableName));
  int version()=>getWrappedInteropObject().version();
}

class RawForeignKeySpec {
  String local;
  String ref;
  lf.ConstraintAction action;
  lf.ConstraintAction timing;

  RawForeignKeySpec({this.local, this.ref,  this.action, this.timing});

  _toInteropMap()=>
      new interop_schema.RawForeignKeySpec(local:local, ref:ref, action:action.index, timing: timing.index);
}

class IndexedColumn {
  bool autoIncrement;
  String name;
  query.Order order;

  IndexedColumn({this.autoIncrement, this.name, this.order});

  _toInteropMap()=>
      new interop_schema.IndexedColumn(autoIncrement: autoIncrement, name:name, order:order.index);
}

enum DataStoreType {
  FIREBASE,
  INDEXED_DB,
  LOCAL_STORAGE,
  MEMORY,
  WEB_SQL
}

typedef void OnUpgradeCallback(raw.BackStore rawDb);

class Column extends lf.PredicateProvider {
  Column(interop_schema.Column interop):super(interop);
  @override
  interop_schema.Column getWrappedInteropObject() {
    return super.getWrappedInteropObject();
  }
  @override
  void setWrappedInteropObject(interop_schema.Column interop) {
    super.setWrappedInteropObject(interop);
  }
  Column as(String name)=>new Column(getWrappedInteropObject().as(name));
  String getName()=>getWrappedInteropObject().getName();
  String getNormalizedName()=>getWrappedInteropObject().getNormalizedName();
}
