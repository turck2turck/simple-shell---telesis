-- Need to delete any attachment that the product matches in the akeneo table
delete from public.product_accessory_assoc where parent_accessory_product_id in (
select p.id from public.product p, loading.akeneo a
where p.product_hash = a.product_hash );


create temporary table tmp_m AS (SELECT a.model_no AS PARENT_MODEL_NO, p.product_model_number AS PRODUCT_MODEL_NO, 
   p.id AS PARENT_ID, a.item_type
     , split_part(a.epn_accessory_products, ',', 1) AS child_sku1
     , split_part(a.epn_accessory_products, ',', 2) AS child_sku2
     , split_part(a.epn_accessory_products, ',', 3) AS child_sku3
     , split_part(a.epn_accessory_products, ',', 4) AS child_sku4
     , split_part(a.epn_accessory_products, ',', 5) AS child_sku5
     , split_part(a.epn_accessory_products, ',', 6) AS child_sku6
     , split_part(a.epn_accessory_products, ',', 7) AS child_sku7
     , split_part(a.epn_accessory_products, ',', 8) AS child_sku8
     , split_part(a.epn_accessory_products, ',', 9) AS child_sku9
     , split_part(a.epn_accessory_products, ',', 10) AS child_sku10
     , split_part(a.epn_accessory_products, ',', 11) AS child_sku11
     , split_part(a.epn_accessory_products, ',', 12) AS child_sku12
     , split_part(a.epn_accessory_products, ',', 13) AS child_sku13
     , split_part(a.epn_accessory_products, ',', 14) AS child_sku14
     , split_part(a.epn_accessory_products, ',', 15) AS child_sku15
     , split_part(a.epn_accessory_products, ',', 16) AS child_sku16
     , split_part(a.epn_accessory_products, ',', 17) AS child_sku17
     , split_part(a.epn_accessory_products, ',', 18) AS child_sku18
     , split_part(a.epn_accessory_products, ',', 19) AS child_sku19
     , split_part(a.epn_accessory_products, ',', 20) AS child_sku20
     , split_part(a.epn_accessory_products, ',', 21) AS child_sku21
     , split_part(a.epn_accessory_products, ',', 22) AS child_sku22
FROM   loading.akeneo a, public.product p
where a.epn_accessory_products is NOT NULL and a.model_no = p.product_model_number);

insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku1 = p.sku and m.child_sku1 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku2 = p.sku and m.child_sku2 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku3 = p.sku and m.child_sku3 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku4 = p.sku and m.child_sku4 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku5 = p.sku and m.child_sku5 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku6 = p.sku and m.child_sku6 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku7 = p.sku and m.child_sku7 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku8 = p.sku and m.child_sku8 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku9 = p.sku and m.child_sku9 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku10 = p.sku and m.child_sku10 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku11 = p.sku and m.child_sku11 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku12 = p.sku and m.child_sku12 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku13 = p.sku and m.child_sku13 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku14 = p.sku and m.child_sku14 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku15 = p.sku and m.child_sku15 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku16 = p.sku and m.child_sku16 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku17 = p.sku and m.child_sku17 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku18 = p.sku and m.child_sku18 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku19 = p.sku and m.child_sku19 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku20 = p.sku and m.child_sku20 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku21 = p.sku and m.child_sku21 is NOT NULL;
insert into product_accessory_assoc (parent_accessory_product_id, child_accessory_product_id)
select m.Parent_id, p.id from tmp_m m, public.product p where m.child_sku22 = p.sku and m.child_sku22 is NOT NULL;
