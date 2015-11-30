
library lf.fn;

import 'schema.dart' as schema;
import 'interop/fn.dart' as interop_fn;

schema.Column avg(schema.Column column)=>
    new schema.Column(interop_fn.avg(column.getWrappedInteropObject()));
schema.Column count([schema.Column column=null])=>
    new schema.Column(interop_fn.count(column!=null?column.getWrappedInteropObject():null));
schema.Column distinct(schema.Column column)=>
    new schema.Column(interop_fn.distinct(column.getWrappedInteropObject()));
schema.Column geomean(schema.Column column)=>
    new schema.Column(interop_fn.geomean(column.getWrappedInteropObject()));
schema.Column max(schema.Column column)=>
    new schema.Column(interop_fn.max(column.getWrappedInteropObject()));
schema.Column min(schema.Column column)=>
    new schema.Column(interop_fn.min(column.getWrappedInteropObject()));
schema.Column stddev(schema.Column column)=>
    new schema.Column(interop_fn.stddev(column.getWrappedInteropObject()));
schema.Column sum(schema.Column column)=>
    new schema.Column(interop_fn.sum(column.getWrappedInteropObject()));
