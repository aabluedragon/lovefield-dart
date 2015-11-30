
@JS('lf.query')
library interop.lf.query;

import 'package:js/js.dart';
import 'promise.dart';
import 'schema.dart' as schema;
import 'lf.dart' as lf;

@JS('Builder')
abstract class Builder {
//  external Builder bind(List<dynamic> values); // TODO(alonam) varargs not suported. Was `bind(...values: any[]): Builder` don't think dart supports varargs yet, so I did this, need to test if it works.
  external Promise<List<Object>> exec();
  external String explain();
  external String toSql();
}

@JS('Delete')
abstract class Delete extends Builder {
  external Delete from(schema.Table table);
  external Delete where(lf.Predicate predicate);
}

@JS('Insert')
abstract class Insert extends Builder {
  external Insert into(schema.Table table);
  external Insert values(dynamic rows); // in ts.d it was `Array<Row>|Binder|Array<Binder>`
}

@JS('Update')
abstract class Update extends Builder {
  external Update set(schema.Column column, dynamic value);
  external Update where(lf.Predicate predicate);
}

@JS('Select')
abstract class Select extends Builder {
//  external Select from(List<schema.Table> tables); // TODO(alonam) varags, d.ts was `...tables: schema.Table[]`
//  external Select groupBy(List<schema.Column> columns); // TODO(alonam) varargs again, in d.ts was `...columns: schema.Column[]`
  external Select innerJoin(schema.Table table, lf.Predicate predicate);
  external Select leftOuterJoin(schema.Table table, lf.Predicate predicate);
  external Select limit(dynamic /*Binder|number*/ numberOfRows);
  external Select orderBy(schema.Column column, [int /*Order*/ order]);
  external Select skip(dynamic /*Binder|number*/ numberOfRows);
  external Select where(lf.Predicate predicate);
}