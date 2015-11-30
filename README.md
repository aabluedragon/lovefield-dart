# lovefield-dart
Lovefield interop for Dart

Getting Started
---
```
import 'package:lovefield/lovefield.dart';

main() async {

  SchemaBuilder schemaBuilder = new SchemaBuilder('PersonsDatabase', 671);
  schemaBuilder.createTable('Person')
      .addColumn('id', ColumnType.INTEGER)
      .addColumn('age', ColumnType.INTEGER)
      .addColumn('name', ColumnType.STRING)
      .addPrimaryKey(['id'])
      .addIndex('idxAge', ['age'], false, Order.ASC);

  try {
    Database db = await schemaBuilder.connect();
    Table personTable = db.getSchema().table('Person');

    Row row = personTable.createRow({'id':5,'name':'Test','age':27});
    await db.insert().into(personTable).values([row]).exec();

    List<Object> objs = await db.select().from1(personTable).where(
      and(personTable.v('age').eq(26),personTable.v('name').eq('Alon'))
    ).exec();

    int a = 1;
  } catch(e) {
    // Do something with exception
  }

}
```