UPDATE loading.akeneo set atero_cat1 = 'default' where atero_cat1 IS NULL;
UPDATE loading.akeneo set atero_cat2 = 'default' where atero_cat2 IS NULL;

UPDATE loading.akeneo set product_hash = md5(ROW(manufacturer.id, akeneo.model_no)::TEXT), mfg_id = manufacturer.id
FROM public.manufacturer
WHERE UPPER(akeneo.manufacturer_name) = UPPER(manufacturer.name);
