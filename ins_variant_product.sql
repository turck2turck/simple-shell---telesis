
INSERT INTO public.variant_product (product_model_number,manufacturer_id,product_hash,name,upc,groups,depth,height,width,diameter,shipping_weight,unit_of_measure,uom_measurement,tax_code,freight_class,freight_code,description,msrp,wholesale_price,wholesale_qty,map,utility_info,sku,product_family,lead_time,created_at,created_by)
SELECT a.model_no,a.mfg_id,a.product_hash,a.name,a.upc,a.groups,a.post_depth,a.height,a.width,NULL,a.post_shipping_weight,a.post_unit_of_measure,a.uom_measurement,a.avalara_tax_code,a.freight_class,a.avalara_freight_code,a.key_features,a.post_msrp,a.price_usd,a.price_by_qty,NULL,a.key_utility_information,a.sku,UPPER(a.product_family),a.lead_time,current_timestamp,1
FROM loading.akeneo a
WHERE a.item_type = 'item_type_variant' and a.enabled='1'
ON CONFLICT (product_hash) DO UPDATE
SET name=EXCLUDED.name,upc=EXCLUDED.upc,groups=EXCLUDED.groups,depth=EXCLUDED.depth,height=EXCLUDED.height,width=EXCLUDED.width,shipping_weight=EXCLUDED.shipping_weight,unit_of_measure=EXCLUDED.unit_of_measure,uom_measurement=EXCLUDED.uom_measurement,tax_code=EXCLUDED.tax_code,freight_class=EXCLUDED.freight_class,freight_code=EXCLUDED.freight_code,description=EXCLUDED.description,msrp=EXCLUDED.msrp,wholesale_price=EXCLUDED.wholesale_price,wholesale_qty=EXCLUDED.wholesale_qty,utility_info=EXCLUDED.utility_info,sku=EXCLUDED.sku,product_family=EXCLUDED.product_family,lead_time=EXCLUDED.lead_time,updated_at=current_timestamp,updated_by=1,deleted_at=NULL,deleted_by=NULL;

UPDATE public.variant_product
SET deleted_at=current_timestamp,deleted_by=1
FROM loading.akeneo a
WHERE a.product_hash=variant_product.product_hash and a.enabled='0';

create temporary table tmp_x as (select max(id) from variant_product group by groups);

INSERT INTO public.product (manufacturer_id,cat_sub_assoc_id,product_model_number,product_hash,type,name,display_name,groups,upc,depth,height,width,diameter,shipping_weight,unit_of_measure,uom_measurement,tax_code,freight_class,freight_code,description,msrp,wholesale_price,wholesale_qty,map,utility_info,sku,product_family,lead_time,option_flag,created_at,created_by)
SELECT a.mfg_id,a.atero_cat_id,a.model_no,a.product_hash,'Variant',a.name,a.display_name,a.groups,a.upc,a.post_depth,a.height,a.width,NULL,a.post_shipping_weight,a.post_unit_of_measure,a.uom_measurement,a.avalara_tax_code,a.freight_class,a.avalara_freight_code,a.key_features,a.post_msrp,a.price_usd,a.price_by_qty,NULL,a.key_utility_information,a.sku,UPPER(a.product_family),a.lead_time,'false',current_timestamp,1
FROM loading.akeneo a, tmp_x x , public.variant_product
WHERE a.item_type = 'item_type_variant' and a.enabled = '1' and a.model_no = v.product_model_number and v.id = x.id and not exists (select 1 from public.product p where p.groups = a.groups) 
ON CONFLICT (product_hash) DO UPDATE
SET cat_sub_assoc_id=EXCLUDED.cat_sub_assoc_id,name=EXCLUDED.name,display_name=EXCLUDED.display_name, groups=EXCLUDED.groups,upc=EXCLUDED.upc,depth=EXCLUDED.depth,height=EXCLUDED.height,width=EXCLUDED.width,shipping_weight=EXCLUDED.shipping_weight,unit_of_measure=EXCLUDED.unit_of_measure,uom_measurement=EXCLUDED.uom_measurement,tax_code=EXCLUDED.tax_code,freight_class=EXCLUDED.freight_class,freight_code=EXCLUDED.freight_code,description=EXCLUDED.description,msrp=EXCLUDED.msrp,wholesale_price=EXCLUDED.wholesale_price,wholesale_qty=EXCLUDED.wholesale_qty,utility_info=EXCLUDED.utility_info,sku=EXCLUDED.sku,product_family=EXCLUDED.product_family,lead_time=EXCLUDED.lead_time,
updated_at=current_timestamp,updated_by=1,deleted_at=NULL,deleted_by=NULL;
