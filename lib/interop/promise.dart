
import 'package:js/js.dart';
import 'dart:async' show Completer, Future;
import 'dart:js' show JsObject;

typedef void CallbackWithParam<T>(T cbParam);

@JS()
abstract class Promise<T> {
  external Promise<T> then(CallbackWithParam<T> cb);
}

Future catchToCompleter(Promise promise, Completer completer) {
  try {
    (promise as JsObject).callMethod('catch',[allowInterop((e){
      completer.completeError(e);
    })]);
  } catch(e) {
    //Ignorring error, happens in db.connect() for example.
  }
  return completer.future.timeout(const Duration(seconds: 5));
}
