# lovefield-dart
Lovefield interop for Dart

This is a Work-In-Progress!
----

Getting Started
---
```java
import 'package:lovefield/lovefield.dart';

main() async {

  SchemaBuilder schemaBuilder = new SchemaBuilder('PersonsDatabase', 1);
  schemaBuilder.createTable('Person')
      .addColumn('id', ColumnType.INTEGER)
      .addColumn('age', ColumnType.INTEGER)
      .addColumn('name', ColumnType.STRING)
      .addPrimaryKey(['id'])
      .addIndex('idxAge', ['age'], false, Order.ASC);

  try {
    Database db = await schemaBuilder.connect();
    Table personTable = db.getSchema().table('Person');

    Row row = personTable.createRow({'id':1,'name':'Alon','age':26});
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

Guided by https://github.com/google/lovefield/blob/40bf6a63c67a40f3bd13196fc2ca7c53d0a33b54/dist/lovefield.d.ts
