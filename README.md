# lovefield-dart
[Lovefield](https://github.com/google/lovefield) interop for Dart

Keep in mind this is a work-in-progress, so even though basic functionality works (as the example below), more advanced features were not tested and might not yet function as expected.

Getting Started
---
```c#
import 'package:lovefield/lovefield.dart';

@LFEntity
class Person {
  String name;
  int age;

  @LFId
  int id;
  sayName() {
    print('I am $name, $age years old, id is $id');
  }
}

main() async {

  SchemaBuilder schemaBuilder = new SchemaBuilder('PersonsDatabase', 999, orm: true);

  schemaBuilder.createTable('Person')
    .addColumn('id', ColumnType.INTEGER)
    .addColumn('age', ColumnType.INTEGER)
    .addColumn('name', ColumnType.STRING)
    .addPrimaryKey(['id'])
    .addIndex('idxAge', ['age'], false, Order.ASC);

  Database db = await schemaBuilder.connect();
  Table personTable = db.getSchema().table('Person');

  Row row = personTable.createRow({'id':12,'name':'Alon','age':26});
  await db.insert().into(personTable).values([row]).exec();

  var orm = schemaBuilder.orm;
  List<Person> objs = await orm.exec(db.select().from1(personTable).where(
      and(personTable.v('age').eq(26),personTable.v('name').eq('Alon'))
  ), Person);

  objs.elementAt(0).sayName();

}
```

Guided by https://github.com/google/lovefield/blob/40bf6a63c67a40f3bd13196fc2ca7c53d0a33b54/dist/lovefield.d.ts
