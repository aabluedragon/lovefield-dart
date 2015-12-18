
library lf.query;

import 'interop/query.dart' as interop_query;
import 'interop/interop_wrapper.dart';
import 'dart:async';
import 'dart:js';
import 'interop/lf.dart' as interop_lf;
import 'schema.dart' as schema;
import 'lf.dart' as lf;
import 'interop/schema.dart' as interop_schema;
import 'interop/promise.dart';

class Builder extends InteropWrapper<interop_query.Builder> {
  Builder(interop_query.Builder interop) {
    setWrappedInteropObject(interop);
  }

  Builder bind([List<dynamic> values]) {
    if(values == null) values = [];
    JsObject obj = (getWrappedInteropObject() as JsObject);
    interop_query.Builder b = obj.callMethod('bind', values);
    return new Builder(b);
  }

  Future<List<Object>> exec() async {
    Completer completer = new Completer();
    return catchToCompleter(
      getWrappedInteropObject().exec().then(allowInterop((List<Object> objs)=>completer.complete(objs)))
    ,completer);
  }
  String explain()=>getWrappedInteropObject().explain();
  String toSql()=>getWrappedInteropObject().toSql();
}


class Delete extends Builder {
  Delete(interop_query.Delete interop):super(interop);
  @override
  interop_query.Delete getWrappedInteropObject() {
    return super.getWrappedInteropObject();
  }
  @override
  void setWrappedInteropObject(interop_query.Delete interop) {
    super.setWrappedInteropObject(interop);
  }
  Delete from(schema.Table table)=>
      new Delete(getWrappedInteropObject().from(table.getWrappedInteropObject()));
  Delete where(interop_lf.Predicate predicate)=>
      new Delete(getWrappedInteropObject().where(predicate));
}


class Insert extends Builder {
  Insert(interop_query.Insert interop):super(interop);
  @override
  interop_query.Insert getWrappedInteropObject() {
    return super.getWrappedInteropObject();
  }
  @override
  void setWrappedInteropObject(interop_query.Insert interop) {
    super.setWrappedInteropObject(interop);
  }
  Insert into(schema.Table table)=>
      new Insert(getWrappedInteropObject().into(table.getWrappedInteropObject()));
  Insert valuesBinder(lf.Binder binder)=>
     new Insert(getWrappedInteropObject().values(binder.getWrappedInteropObject()));
  Insert valuesBinders(List<lf.Binder> binders) {
    List<interop_lf.Binder> interopBinders = binders.map((lf.Binder binder)=>binder.getWrappedInteropObject()).toList();
    return new Insert(getWrappedInteropObject().values(interopBinders));
  }
  Insert values(List<interop_schema.Row> rows)=>
    new Insert(getWrappedInteropObject().values(rows));
}

class Update extends Builder {
  Update(interop_query.Update interop):super(interop);
  @override
  interop_query.Update getWrappedInteropObject() {
    return super.getWrappedInteropObject();
  }
  @override
  void setWrappedInteropObject(interop_query.Update interop) {
    super.setWrappedInteropObject(interop);
  }
  Update set(schema.Column column, dynamic value)=>
      new Update(getWrappedInteropObject().set(column.getWrappedInteropObject(), value));
  Update where(interop_lf.Predicate predicate)=>
      new Update(getWrappedInteropObject().where(predicate));
}

enum Order { ASC, DESC }

class Select extends Builder {
  Select(interop_query.Select interop):super(interop);
  @override
  interop_query.Select getWrappedInteropObject() {
    return super.getWrappedInteropObject();
  }
  @override
  void setWrappedInteropObject(interop_query.Select interop) {
    super.setWrappedInteropObject(interop);
  }

  Select from1(schema.Table table)=>
      from([table]);

  Select from([List<schema.Table> tables=const[]]) {
    List<interop_schema.Table> interopTables = tables.map((schema.Table table)=>table.getWrappedInteropObject()).toList();
    JsObject interopJsObj = (getWrappedInteropObject() as JsObject);
    interop_query.Select retValInterop = interopJsObj.callMethod('from', interopTables);
    return new Select(retValInterop);
  }
  Select groupBy([List<schema.Column> columns=const[]]) {
    List<interop_schema.Column> interopColumns = columns.map((schema.Column column)=>column.getWrappedInteropObject()).toList();
    JsObject interopJsObj = (getWrappedInteropObject() as JsObject);
    interop_query.Select retValInterop = interopJsObj.callMethod('from', interopColumns);
    return new Select(retValInterop);
  }
  Select innerJoin(schema.Table table, interop_lf.Predicate predicate)=>
      new Select(getWrappedInteropObject().innerJoin(table.getWrappedInteropObject(), predicate));
  Select leftOuterJoin(schema.Table table, interop_lf.Predicate predicate)=>
      new Select(getWrappedInteropObject().leftOuterJoin(table.getWrappedInteropObject(), predicate));
  Select limit(num numberOfRows)=>
      new Select(getWrappedInteropObject().limit(numberOfRows));
  Select limitBinder(lf.Binder binder)=>
      new Select(getWrappedInteropObject().limit(binder.getWrappedInteropObject()));
  Select orderBy(schema.Column column, [Order order])=>
      new Select(getWrappedInteropObject().orderBy(column.getWrappedInteropObject(), order!=null?order.index:null));
  Select skip(num numberOfRows) =>
      new Select(getWrappedInteropObject().skip(numberOfRows));
  Select skipBinder(lf.Binder binder) =>
      new Select(getWrappedInteropObject().skip(binder.getWrappedInteropObject()));
  Select where(interop_lf.Predicate predicate)=>
      new Select(getWrappedInteropObject().where(predicate));
}