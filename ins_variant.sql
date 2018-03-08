INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_1,variant_axis_1_value,variant_hash1
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_1 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_2,variant_axis_2_value,variant_hash2
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_2 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_3,variant_axis_3_value,variant_hash3
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_3 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_4,variant_axis_4_value,variant_hash4
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_4 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_5,variant_axis_5_value,variant_hash5
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_5 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_6,variant_axis_6_value,variant_hash6
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_6 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_7,variant_axis_7_value,variant_hash7
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_7 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_8,variant_axis_8_value,variant_hash8
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_8 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_9,variant_axis_9_value,variant_hash9
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_9 IS NOT NULL ON CONFLICT do nothing;

INSERT INTO public.variant(variant,value,variant_hash)
SELECT variant_axis_10,variant_axis_10_value,variant_hash10
FROM loading.akeneo where item_type = 'item_type_variant' AND variant_axis_10 IS NOT NULL ON CONFLICT do nothing;
