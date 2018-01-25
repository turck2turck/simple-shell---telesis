UPDATE loading.akeneo set atero_cat1 = 'default' where atero_cat1 IS NULL;
UPDATE loading.akeneo set atero_cat2 = 'default' where atero_cat2 IS NULL;

UPDATE loading.akeneo set product_hash = md5(ROW(manufacturer.id, akeneo.model_no)::TEXT), mfg_id = manufacturer.id
FROM public.manufacturer
WHERE UPPER(akeneo.manufacturer_name) = UPPER(manufacturer.short_name);

UPDATE loading.akeneo set atero_cat_id = a.id
FROM public.cat_sub_assoc a, public.category c, public.sub_category s
WHERE atero_cat1 = c.category_name
  AND atero_cat2 = s.sub_category_name
  AND a.category_id = c.id
  AND a.sub_category_id = s.id;
