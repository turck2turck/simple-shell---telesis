UPDATE loading.akeneo set atero_cat1 = 'default' where atero_cat1 IS NULL;
UPDATE loading.akeneo set atero_cat2 = 'default' where atero_cat2 IS NULL;

UPDATE loading.akeneo set product_hash = md5(ROW(manufacturer.id, akeneo.model_no)::TEXT), mfg_id = manufacturer.id
FROM public.manufacturer
WHERE UPPER(akeneo.manufacturer_name) = UPPER(manufacturer.short_name);

UPDATE loading.akeneo set variant_hash1 = md5(ROW(variant_axis_1, variant_avis_1_value)::TEXT) where variant_axis_1 is NOT NULL;
UPDATE loading.akeneo set variant_hash2 = md5(ROW(variant_axis_2, variant_avis_2_value)::TEXT) where variant_axis_2 is NOT NULL;
UPDATE loading.akeneo set variant_hash3 = md5(ROW(variant_axis_3, variant_avis_3_value)::TEXT) where variant_axis_3 is NOT NULL;
UPDATE loading.akeneo set variant_hash4 = md5(ROW(variant_axis_4, variant_avis_4_value)::TEXT) where variant_axis_4 is NOT NULL;
UPDATE loading.akeneo set variant_hash5 = md5(ROW(variant_axis_5, variant_avis_5_value)::TEXT) where variant_axis_5 is NOT NULL;
UPDATE loading.akeneo set variant_hash6 = md5(ROW(variant_axis_6, variant_avis_6_value)::TEXT) where variant_axis_6 is NOT NULL;
UPDATE loading.akeneo set variant_hash7 = md5(ROW(variant_axis_7, variant_avis_7_value)::TEXT) where variant_axis_7 is NOT NULL;
UPDATE loading.akeneo set variant_hash8 = md5(ROW(variant_axis_8, variant_avis_8_value)::TEXT) where variant_axis_8 is NOT NULL;
UPDATE loading.akeneo set variant_hash9 = md5(ROW(variant_axis_9, variant_avis_9_value)::TEXT) where variant_axis_9 is NOT NULL;
UPDATE loading.akeneo set variant_hash10 = md5(ROW(variant_axis_10, variant_avis_10_value)::TEXT) where variant_axis_10 is NOT NULL;

UPDATE loading.akeneo set atero_cat_id = a.id
FROM public.cat_sub_assoc a, public.category c, public.sub_category s
WHERE atero_cat1 = c.category_name
  AND atero_cat2 = s.sub_category_name
  AND a.category_id = c.id
  AND a.sub_category_id = s.id;
