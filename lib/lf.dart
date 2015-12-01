
library lf;

import 'interop/lf.dart' as interop_lf;
import 'interop/interop_wrapper.dart';
import 'dart:async';
import 'query.dart' as query;
import 'schema.dart' as schema;
import 'interop/schema.dart' as interop_schema;
import 'package:js/js.dart';
import 'dart:js';
import 'interop/query.dart' as interop_query;
import 'interop/promise.dart';

Binder bind(int index)=>new Binder(interop_lf.bind(index));

class Transaction extends InteropWrapper<interop_lf.Transaction> {

  Transaction(interop_lf.Transaction interop) {
    setWrappedInteropObject(interop);
  }

  Future<List<Object>> attach(query.Builder query) async {
    Completer<List<Object>> completer = new Completer();

    return catchToCompleter(
      getWrappedInteropObject().attach(query.getWrappedInteropObject()).then((List<Object> objects){
        completer.complete(objects);
      })
    ,completer);
  }
  Future begin(List<schema.Table> scope) async {
    Completer completer = new Completer();
    List<interop_schema.Table> convertedScope = scope.map((schema.Table table)=>table.getWrappedInteropObject()).toList();
    return catchToCompleter(
    getWrappedInteropObject().begin(convertedScope).then((dummy){
      completer.complete();
    }),completer);
  }
  Future commit() async {
    Completer completer = new Completer();
    return catchToCompleter(
      getWrappedInteropObject().commit().then((dummy)=>completer.complete())
    ,completer);
  }
  Future<List<List<Object>>> exec(List<query.Builder> queries) async {
    Completer<List<List<Object>>> completer = new Completer();
    List<interop_query.Builder> interopQueries = queries.map((query.Builder builder)=>builder.getWrappedInteropObject()).toList();
    return catchToCompleter(
      getWrappedInteropObject().exec(interopQueries).then((List<List<Object>> retVal)=>completer.complete(retVal))
    ,completer);
  }
  Future rollback() async {
    Completer completer = new Completer();
    return catchToCompleter(
      getWrappedInteropObject().rollback().then((dummy)=>completer.complete())
    ,completer);
  }
  interop_lf.TransactionStats stats()=>getWrappedInteropObject().stats();
}

enum ColumnType {
  ARRAY_BUFFER,
  BOOLEAN,
  DATE_TIME,
  INTEGER,
  NUMBER,
  STRING,
  OBJECT
}

enum TransactionType { READ_ONLY, READ_WRITE }

class Database extends InteropWrapper<interop_lf.Database> {
  Database(interop_lf.Database interop) {
    setWrappedInteropObject(interop);
  }

  void close()=>getWrappedInteropObject().close();

  Transaction createTransaction([TransactionType type])=>
      new Transaction(getWrappedInteropObject().createTransaction(type.index));
  query.Delete delete()=>
      new query.Delete(getWrappedInteropObject().delete());
  Future<Object> export() {
    Completer<Object> completer = new Completer();
    return catchToCompleter(
    getWrappedInteropObject().export().then((Object obj){
      completer.complete(obj);
    }),completer);
  }
  schema.DatabaseInfo getSchema()=>
      new schema.DatabaseInfo(getWrappedInteropObject().getSchema());

  Future import(Map data) async {
    Completer completer = new Completer();
    return catchToCompleter(
      getWrappedInteropObject().import(new JsObject.jsify(data)).then((dummy)=>completer.complete())
    ,completer);
  }

  query.Insert insertOrReplace()=>
      new query.Insert(getWrappedInteropObject().insertOrReplace());

  query.Insert insert()=>
      new query.Insert(getWrappedInteropObject().insert());

  void observe(query.Select query, Function callback)=>
      getWrappedInteropObject().observe(query.getWrappedInteropObject(), allowInterop(callback));

  query.Select select([List<schema.Column> columns=const[]]) {
    JsObject wrapped = (getWrappedInteropObject() as JsObject);
    List<interop_schema.Column> interopColumns = columns.map((schema.Column column)=>column.getWrappedInteropObject()).toList();
    JsObject interopRetVal = wrapped.callMethod('select', interopColumns);
    return new query.Select((interopRetVal as interop_query.Select));
  }
  void unobserve(query.Select query, Function callback)=>
      getWrappedInteropObject().unobserve(query.getWrappedInteropObject(), allowInterop(callback));
  query.Update update(schema.Table table)=>
      new query.Update(getWrappedInteropObject().update(table.getWrappedInteropObject()));
}

class PredicateProvider extends InteropWrapper<interop_lf.PredicateProvider> {

  PredicateProvider(interop_lf.PredicateProvider interop) {
    setWrappedInteropObject(interop);
  }

  interop_lf.Predicate eq(dynamic operand)=>getWrappedInteropObject().eq(operand);
  interop_lf.Predicate eqColumn(schema.Column operand)=>getWrappedInteropObject().eq(operand.getWrappedInteropObject());
  interop_lf.Predicate eqBinder(Binder operand)=>getWrappedInteropObject().eq(operand.getWrappedInteropObject());

  interop_lf.Predicate neq(dynamic operand)=>getWrappedInteropObject().neq(operand);
  interop_lf.Predicate neqColumn(schema.Column operand)=>getWrappedInteropObject().neq(operand.getWrappedInteropObject());
  interop_lf.Predicate neqBinder(Binder operand)=>getWrappedInteropObject().neq(operand.getWrappedInteropObject());

  interop_lf.Predicate lt(dynamic operand)=>getWrappedInteropObject().lt(operand);
  interop_lf.Predicate ltColumn(schema.Column operand)=>getWrappedInteropObject().lt(operand.getWrappedInteropObject());
  interop_lf.Predicate ltBinder(Binder operand)=>getWrappedInteropObject().lt(operand.getWrappedInteropObject());

  interop_lf.Predicate lte(dynamic operand)=>getWrappedInteropObject().lte(operand);
  interop_lf.Predicate lteColumn(schema.Column operand)=>getWrappedInteropObject().lte(operand.getWrappedInteropObject());
  interop_lf.Predicate lteBinder(Binder operand)=>getWrappedInteropObject().lte(operand.getWrappedInteropObject());

  interop_lf.Predicate gt(dynamic operand)=>getWrappedInteropObject().gt(operand);
  interop_lf.Predicate gtColumn(schema.Column operand)=>getWrappedInteropObject().gt(operand.getWrappedInteropObject());
  interop_lf.Predicate gtBinder(Binder operand)=>getWrappedInteropObject().gt(operand.getWrappedInteropObject());

  interop_lf.Predicate gte(dynamic operand)=>getWrappedInteropObject().gte(operand);
  interop_lf.Predicate gteColumn(schema.Column operand)=>getWrappedInteropObject().gte(operand.getWrappedInteropObject());
  interop_lf.Predicate gteBinder(Binder operand)=>getWrappedInteropObject().gte(operand.getWrappedInteropObject());

  interop_lf.Predicate match(RegExp operand)=>
    getWrappedInteropObject().match(operand);
  interop_lf.Predicate matchBinder(Binder operand)=>
    getWrappedInteropObject().match(operand.getWrappedInteropObject());

  interop_lf.Predicate betweenBinderAndBinder(Binder from, Binder to)=>getWrappedInteropObject().between(from.getWrappedInteropObject(), to.getWrappedInteropObject());
  interop_lf.Predicate betweenBinderAndValue(Binder from, dynamic to)=>getWrappedInteropObject().between(from.getWrappedInteropObject(), to);
  interop_lf.Predicate betweenValueAndBinder(dynamic from, Binder to)=>getWrappedInteropObject().between(from, to.getWrappedInteropObject());
  interop_lf.Predicate betweenValues(dynamic from, dynamic to)=>getWrappedInteropObject().between(from, to);

  interop_lf.Predicate $in(List<dynamic> values) =>
    (getWrappedInteropObject() as JsObject).callMethod('in', [values]);

  interop_lf.Predicate inBinder(Binder binder) =>
      (getWrappedInteropObject() as JsObject).callMethod('in', [binder.getWrappedInteropObject()]);

  interop_lf.Predicate isNull()=>getWrappedInteropObject().isNull();
  interop_lf.Predicate isNotNull()=>getWrappedInteropObject().isNotNull();
}

enum ConstraintAction {
  RESTRICT,
  CASCADE
}

class Binder extends InteropWrapper<interop_lf.Binder> {
  Binder(interop_lf.Binder interop) {
    setWrappedInteropObject(interop);
  }
  int getIndex()=>getWrappedInteropObject().getIndex();
}

