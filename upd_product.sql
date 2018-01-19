UPDATE public.product p
SET cat_sub_assoc_id=e.atero_cat_id, type='Product', name=e.name, depth=e.length, height=e.height, width=e.width, shipping_weight=e.shipping_weight, tax_code=e.avalara_tax_code, freight_class=e.freight_class, freight_code=e.avalara_freight_code, description=e.key_features, msrp=e.price_usd, utility_info=e.key_utility_information, sku=e.sku, updated_at=current_timestamp, updated_by=2
FROM loading.akeneo_error e
WHERE e.error_msg = 'Update' and e.product_hash = p.product_hash and e.item_type = 'item_type_product';

UPDATE public.product p
SET cat_sub_assoc_id=e.atero_cat_id, type='Accessory', name=e.name, depth=e.length, height=e.height, width=e.width, shipping_weight=e.shipping_weight, tax_code=e.avalara_tax_code, freight_class=e.freight_class, freight_code=e.avalara_freight_code, description=e.key_features, msrp=e.price_usd, utility_info=e.key_utility_information, sku=e.sku, updated_at=current_timestamp, updated_by=2
FROM loading.akeneo_error e
WHERE e.error_msg = 'Update' and e.product_hash = p.product_hash and e.item_type = 'item_type_accessory';

UPDATE public.product p
SET cat_sub_assoc_id=e.atero_cat_id, type='Product', name=e.name, depth=e.length, height=e.height, width=e.width, shipping_weight=e.shipping_weight, tax_code=e.avalara_tax_code, freight_class=e.freight_class, freight_code=e.avalara_freight_code, description=e.key_features, msrp=e.price_usd, utility_info=e.key_utility_information, sku=e.sku, updated_at=current_timestamp, updated_by=2
FROM loading.akeneo_error e
WHERE e.error_msg = 'Update' and e.product_hash = p.product_hash and e.item_type = 'item_type_option';
