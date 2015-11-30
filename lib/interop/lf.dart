// TODO(alonam) support JS Date `new Date()`, Type.DATE_TIME

@JS('lf')
library interop.lf;

import 'package:js/js.dart';
import 'promise.dart' show Promise;
import 'schema.dart' show Table;
import 'query.dart' as query;
import 'schema.dart' as schema;


@JS()
abstract class Transaction {
  external Promise<List<Object>> attach(query.Builder query);
  external Promise<Null> begin(List<Table> scope);
  external Promise<Null> commit();
  external Promise<List<List<Object>>> exec(List<query.Builder> queries);
  external Promise<Null> rollback();
}

@JS()
abstract class Database {
  external void close();
  external Transaction createTransaction([/*TransactionType*/ type]);
  external query.Delete delete();
  external Promise<Object> export();
  external schema.DatabaseInfo getSchema();
  external Promise<Null> import(Object data);
  external query.Insert insertOrReplace();
  external query.Insert insert();
  external void observe(query.Select query, Function callback); // TODO(alonam): MUST TEST! maybe it will crash if not dynamic.
//  external query.Select select(List<schema.Column> columns); // TODO(alonam) varargs... was `...columns: schema.Column[]`
  external void unobserve(query.Select query, Function callback); // TODO(alonam): MUST TEST! maybe it will crash if not dynamic.
  external query.Update update(schema.Table table);
}

@JS()
abstract class Predicate {}

// type ValueLiteral = string|number|boolean|Date; (No way to typedef this or dynamic in Dart, no aliasing).

@JS()
abstract class PredicateProvider {
  external Predicate eq(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate neq(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate lt(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate lte(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate gt(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate gte(dynamic /*ValueLiteral|schema.Column|Binder*/ operand);
  external Predicate match(dynamic /*RegExp|Binder*/ operand);
  external Predicate between(dynamic /*ValueLiteral|Binder*/ from, dynamic /*ValueLiteral|Binder*/ to);
//  external Predicate in(dynamic /*Binder|Array<ValueLiteral>*/ values); // once `$JS$` is supported, it should work (`in` is reserved in Dart)
  external Predicate isNull();
  external Predicate isNotNull();
}

@JS('Binder')
class Binder {
  external int getIndex();
  external Binder();
}
