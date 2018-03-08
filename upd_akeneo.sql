UPDATE loading.akeneo SET atero_cat2 = 'default' WHERE atero_cat2 IS NULL;

UPDATE loading.akeneo SET product_hash = md5(ROW(manufacturer.id, akeneo.model_no)::TEXT), mfg_id = manufacturer.id
FROM public.manufacturer
WHERE UPPER(akeneo.manufacturer_name) = UPPER(manufacturer.short_name);

UPDATE loading.akeneo SET variant_hash1 = md5(ROW(variant_axis_1, variant_axis_1_value)::TEXT) WHERE variant_axis_1 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash2 = md5(ROW(variant_axis_2, variant_axis_2_value)::TEXT) WHERE variant_axis_2 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash3 = md5(ROW(variant_axis_3, variant_axis_3_value)::TEXT) WHERE variant_axis_3 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash4 = md5(ROW(variant_axis_4, variant_axis_4_value)::TEXT) WHERE variant_axis_4 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash5 = md5(ROW(variant_axis_5, variant_axis_5_value)::TEXT) WHERE variant_axis_5 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash6 = md5(ROW(variant_axis_6, variant_axis_6_value)::TEXT) WHERE variant_axis_6 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash7 = md5(ROW(variant_axis_7, variant_axis_7_value)::TEXT) WHERE variant_axis_7 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash8 = md5(ROW(variant_axis_8, variant_axis_8_value)::TEXT) WHERE variant_axis_8 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash9 = md5(ROW(variant_axis_9, variant_axis_9_value)::TEXT) WHERE variant_axis_9 IS NOT NULL;
UPDATE loading.akeneo SET variant_hash10 = md5(ROW(variant_axis_10, variant_axis_10_value)::TEXT) WHERE variant_axis_10 IS NOT NULL;

UPDATE loading.akeneo SET atero_cat_id = a.id
FROM public.cat_sub_assoc a, public.category c, public.sub_category s
WHERE atero_cat1 = c.category_name
  AND atero_cat2 = s.sub_category_name
  AND a.category_id = c.id
  AND a.sub_category_id = s.id;

UPDATE loading.akeneo SET post_msrp = price_usd/price_by_qty WHERE enabled= '1';
UPDATE loading.akeneo SET post_shipping_weight = shipping_weight/per_case WHERE enabled= '1';
UPDATE loading.akeneo SET post_depth = length/per_case WHERE uom_measuerment = '0' AND enabled = '1';
UPDATE loading.akeneo SET post_depth = depth WHERE enabled= '1';
