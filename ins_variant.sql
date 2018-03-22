

insert into public.variant(variant,value,variant_hash)
select variant_axis_1,variant_axis_1_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_2,variant_axis_2_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_3,variant_axis_3_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_4,variant_axis_4_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_5,variant_axis_5_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_6,variant_axis_6_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_7,variant_axis_7_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_8,variant_axis_8_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_9,variant_axis_9_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
insert into public.variant(variant,value,variant_hash)
select variant_axis_10,variant_axis_10_value,variant_hash
from loading.akeneo where item_type = 'item_type_variant' and variant_axis_1 is NOT NULL;
