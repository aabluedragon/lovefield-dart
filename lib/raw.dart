
library lf.raw;

import 'interop/schema.dart' as interop_schema;
import 'interop/promise.dart';
import 'interop/interop_wrapper.dart';
import 'interop/raw.dart' as interop_raw;
import 'dart:async';
import 'dart:js';

class BackStore extends InteropWrapper<interop_raw.BackStore> {

  BackStore(interop_raw.BackStore interop) {
    setWrappedInteropObject(interop);
  }

  dynamic getRawDBInstance()=>getWrappedInteropObject().getRawDBInstance();
  dynamic getRawTransaction()=>getWrappedInteropObject().getRawTransaction();

  Future dropTable(String tableName) async {
    Completer completer = new Completer();
    return catchToCompleter(
      getWrappedInteropObject().dropTable(tableName).then(allowInterop((dummy){
        completer.complete();
      }))
    ,completer);
  }

  Future addTableColumn(String tableName, String columnName, dynamic defaultValue) async {
    Completer completer = new Completer();
    return catchToCompleter(
        getWrappedInteropObject().addTableColumn(tableName, columnName, defaultValue).then(allowInterop((dummy){
          completer.complete();
        }))
    ,completer);
  }

  Future dropTableColumn(String tableName, String columnName) async {
    Completer completer = new Completer();
    return catchToCompleter(
        getWrappedInteropObject().dropTableColumn(tableName, columnName).then(allowInterop((dummy){
          completer.complete();
        }))
    ,completer);
  }
  Future renameTableColumn(String tableName, String oldColumnName, String newColumnName) async {
    Completer completer = new Completer();
    return catchToCompleter(
        getWrappedInteropObject().renameTableColumn(tableName, oldColumnName, newColumnName).then(allowInterop((dummy){
          completer.complete();
        }))
    ,completer);
  }

  interop_schema.Row createRow(Map payload)=>
      getWrappedInteropObject().createRow(new JsObject.jsify(payload));
  int getVersion()=>getWrappedInteropObject().getVersion();

  List<Object> dump()=>getWrappedInteropObject().dump();
}