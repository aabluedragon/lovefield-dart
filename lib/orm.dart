import 'package:reflectable/reflectable.dart';
import 'schema.dart' as schema;
import 'lf.dart';
import 'query.dart';
import 'dart:async';
import 'package:reflectable/mirrors.dart';
import 'dart:js';
import 'interop/promise.dart';

class RLFEntity extends Reflectable {
  const RLFEntity()
      : super(invokingCapability, declarationsCapability); // Request the capability to invoke methods.
}

const LFEntity = const RLFEntity();

class RLFId extends Reflectable {
  const RLFId()
      : super(declarationsCapability); // Request the capability to invoke methods.
}

const LFId = const RLFId();

class LfOrm {

  schema.SchemaBuilder _dbSchema;

  LfOrm(schema.SchemaBuilder this._dbSchema, [List<Type> entities]){
    Iterable<ClassMirror> icm = LFEntity.annotatedClasses;
    for(ClassMirror m in icm) {
      entityMirrors.putIfAbsent(m.reflectedType, ()=>m);
      createTableForClassMirror(m);
    }

    // TODO if entities is null, then all entities, otherwise, take only given entities.
  }

  void createTableForClassMirror(ClassMirror m) {

    //Eventually... do it-
    //entityTables.putIfAbsent(m.reflectedType, ()=>_dbSchema.getSchema().table(m.simpleName));
  }

  persist(List<dynamic> objs) {

  }

  Future<List<dynamic>> exec(Builder builder, Type type) async {
    Completer<List<dynamic>> completer = new Completer();

    return catchToCompleter(
      builder.getWrappedInteropObject().exec().then((List<dynamic> objs) {
        ClassMirror cm = entityMirrors[type];
        if(cm?.reflectedType == type) {
          var members = cm.declarations.values;

          List retVal = new List();
          objs.forEach((JsObject obj){
            Object p = cm.newInstance('',[]);
            InstanceMirror m = LFEntity.reflect(p);

            members.forEach((DeclarationMirror memberMirror){
              if(memberMirror is VariableMirror && obj.hasProperty(memberMirror.simpleName)) {
                m.invokeSetter(memberMirror.simpleName, obj[memberMirror.simpleName]);
              }
            });
            retVal.add(p);
          });
          completer.complete(retVal);
        }
      }), completer);
  }

  Map<Type, ClassMirror> entityMirrors = new Map();
  Map<Type, schema.Table> entityTables = new Map();
  schema.Table table(Type type)=>entityTables[type];
}