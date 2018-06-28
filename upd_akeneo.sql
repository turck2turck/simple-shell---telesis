UPDATE loading.akeneo set atero_cat2 = 'default' where atero_cat2 IS NULL;

UPDATE loading.akeneo set model_no = REPLACE(model_no, '‐','-');
UPDATE loading.akeneo set sku = REPLACE(sku, '‐','-');

--UPDATE loading.akeneo set product_hash = md5(ROW(manufacturer.id, akeneo.model_no)::TEXT), mfg_id = manufacturer.id
UPDATE loading.akeneo set product_hash = md5(ROW(akeneo.model_no,manufacturer.id)::TEXT), mfg_id = manufacturer.id
FROM public.manufacturer
WHERE UPPER(manufacturer_abbreviation) = UPPER(mfr_abbr);

UPDATE loading.akeneo set variant_hash1 = md5(ROW(variant_axis_1, variant_axis_1_value)::TEXT) where variant_axis_1 is NOT NULL;
UPDATE loading.akeneo set variant_hash2 = md5(ROW(variant_axis_2, variant_axis_2_value)::TEXT) where variant_axis_2 is NOT NULL;
UPDATE loading.akeneo set variant_hash3 = md5(ROW(variant_axis_3, variant_axis_3_value)::TEXT) where variant_axis_3 is NOT NULL;
UPDATE loading.akeneo set variant_hash4 = md5(ROW(variant_axis_4, variant_axis_4_value)::TEXT) where variant_axis_4 is NOT NULL;
UPDATE loading.akeneo set variant_hash5 = md5(ROW(variant_axis_5, variant_axis_5_value)::TEXT) where variant_axis_5 is NOT NULL;
UPDATE loading.akeneo set variant_hash6 = md5(ROW(variant_axis_6, variant_axis_6_value)::TEXT) where variant_axis_6 is NOT NULL;
UPDATE loading.akeneo set variant_hash7 = md5(ROW(variant_axis_7, variant_axis_7_value)::TEXT) where variant_axis_7 is NOT NULL;
UPDATE loading.akeneo set variant_hash8 = md5(ROW(variant_axis_8, variant_axis_8_value)::TEXT) where variant_axis_8 is NOT NULL;
UPDATE loading.akeneo set variant_hash9 = md5(ROW(variant_axis_9, variant_axis_9_value)::TEXT) where variant_axis_9 is NOT NULL;
UPDATE loading.akeneo set variant_hash10 = md5(ROW(variant_axis_10, variant_axis_10_value)::TEXT) where variant_axis_10 is NOT NULL;

UPDATE loading.akeneo set atero_cat_id = a.id
FROM public.cat_sub_assoc a, public.category c, public.sub_category s
WHERE atero_cat2 = s.sub_category_name
  AND a.sub_category_id = s.id;

UPDATE loading.akeneo SET post_shipping_weight = shipping_weight/per_case WHERE enabled='1';
UPDATE loading.akeneo SET post_msrp = price_usd/price_by_qty WHERE enabled='1';
UPDATE loading.akeneo SET post_depth = length/per_case WHERE enabled='1' and uom_measurement='0';
UPDATE loading.akeneo SET post_depth = length WHERE enabled='1' and uom_measurement='1';

UPDATE loading.akeneo SET post_unit_of_measure = 'Individually' where selling_unit = 'selling_unit_single' and enabled='1'; 
UPDATE loading.akeneo SET post_unit_of_measure = 'By Case' where selling_unit = 'selling_unit_case' and enabled='1'; 

UPDATE loading.akeneo SET post_msrp = 1 WHERE post_msrp='0';

UPDATE loading.akeneo SET display_name = REPLACE(groups,'_',' ') where item_type = 'item_type_variant' ;
UPDATE loading.akeneo SET display_name = REPLACE(display_name,',','') where item_type = 'item_type_variant' ;

