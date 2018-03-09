delete from public.product_attachment where option_product_id in (
   select p.id from public.option_product p, loading.akeneo_error a 
   where p.product_hash = a.product_hash and a.enabled = '0');
delete from public.product_attachment where product_id in (
   select p.id from public.product p, loading.akeneo_error a 
   where p.product_hash = a.product_hash and a.enabled = '0');
delete from public.product_attachment where variant_product_id in (
   select p.id from public.variant_product p, loading.akeneo_error a
   where p.product_hash = a.product_hash and a.enabled = '0');

delete from public.product_variant_assoc where variant_product_id in (
   select p.id from public.variant_product p, loading.akeneo_error a
   where p.product_hash = a.product_hash and a.enabled = '0');

delete from public.product_accessory_assoc where parent_accessory_product_id in (
   select p.id from public.product p, loading.akeneo_error a
   where p.product_hash = a.product_hash and a.enabled = '0');

delete from public.product_option_assoc where parent_product_id in (
   select p.id from public.product p, loading.akeneo_error a
   where p.product_hash = a.product_hash and a.enabled = '0');
delete from public.product_option_assoc where parent_product_id in (
  select p.id from public.option_product p, loading.akeneo_error a
   where p.product_hash = a.product_hash and a.enabled = '0');

update public.product set deleted_by = 1, deleted_at = current_timestamp, product_hash = md5(ROW(m.id, a.model_no, a.enabled)::TEXT)
FROM public.manufacturer m, loading.akeneo_error a
where UPPER(a.manufacturer_name) = UPPER(m.short_name)
and product.product_hash in (select product_hash from loading.akeneo_error) ;

update public.option_product set deleted_by = 1, deleted_at = current_timestamp, product_hash = md5(ROW(m.id, a.model_no, a.enabled)::TEXT)
FROM public.manufacturer m , loading.akeneo_error a
where UPPER(a.manufacturer_name) = UPPER(m.short_name)
and product.product_hash in (select product_hash from loading.akeneo_error) ;

update public.variant_product set deleted_by = 1, deleted_at = current_timestamp, product_hash = md5(ROW(m.id, a.model_no, a.enabled)::TEXT)
FROM public.manufacturer m , loading.akeneo_error a
where UPPER(a.manufacturer_name) = UPPER(m.short_name)
and product.product_hash in (select product_hash from loading.akeneo_error) ;
