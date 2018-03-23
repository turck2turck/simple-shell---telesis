-- Need to delete any  that the product matches in the akeneo table
delete from public.product_option_assoc where parent_product_id in (
select p.id from public.product p, loading.akeneo a
where p.product_hash = a.product_hash );

delete from public.product_option_assoc where parent_product_id in (
select p.id from public.option_product p, loading.akeneo a
where p.product_hash = a.product_hash );

create temporary table tmp_m AS (SELECT p.id,a.model_no,a.product_hash,a.item_type
     , split_part(a.epn_option_products, ',', 1) AS child_sku1
     , split_part(a.epn_option_products, ',', 2) AS child_sku2
     , split_part(a.epn_option_products, ',', 3) AS child_sku3
     , split_part(a.epn_option_products, ',', 4) AS child_sku4
     , split_part(a.epn_option_products, ',', 5) AS child_sku5
     , split_part(a.epn_option_products, ',', 6) AS child_sku6
     , split_part(a.epn_option_products, ',', 7) AS child_sku7
     , split_part(a.epn_option_products, ',', 8) AS child_sku8
     , split_part(a.epn_option_products, ',', 9) AS child_sku9
     , split_part(a.epn_option_products, ',', 10) AS child_sku10
FROM loading.akeneo a, public.product p
where a.product_hash = p.product_hash and a.item_type = 'item_type_product' and a.epn_option_products is NOT NULL);

insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku1 = o.sku and m.child_sku1 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku2 = o.sku and m.child_sku2 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku3 = o.sku and m.child_sku3 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku4 = o.sku and m.child_sku4 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku5 = o.sku and m.child_sku5 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku6 = o.sku and m.child_sku6 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku7 = o.sku and m.child_sku7 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku8 = o.sku and m.child_sku8 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku9 = o.sku and m.child_sku9 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku10 = o.sku and m.child_sku10 is NOT NULL;


create temporary table tmp_c AS (SELECT o.id,a.model_no,a.product_hash,a.item_type
     , split_part(a.epn_option_products, ',', 1) AS child_sku1
     , split_part(a.epn_option_products, ',', 2) AS child_sku2
     , split_part(a.epn_option_products, ',', 3) AS child_sku3
     , split_part(a.epn_option_products, ',', 4) AS child_sku4
     , split_part(a.epn_option_products, ',', 5) AS child_sku5
     , split_part(a.epn_option_products, ',', 6) AS child_sku6
     , split_part(a.epn_option_products, ',', 7) AS child_sku7
     , split_part(a.epn_option_products, ',', 8) AS child_sku8
     , split_part(a.epn_option_products, ',', 9) AS child_sku9
     , split_part(a.epn_option_products, ',', 10) AS child_sku10
FROM loading.akeneo a, public.option_product o
where a.product_hash = o.product_hash and a.item_type = 'item_type_option' and a.epn_option_products is NOT NULL);

create temporary table tmp_o as (select * from public.option_product);

insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku1 = o.sku and c.child_sku1 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku2 = o.sku and c.child_sku2 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku3 = o.sku and c.child_sku3 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku4 = o.sku and c.child_sku4 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku5 = o.sku and c.child_sku5 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku6 = o.sku and c.child_sku6 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku7 = o.sku and c.child_sku7 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku8 = o.sku and c.child_sku8 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku9 = o.sku and c.child_sku9 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku10 = o.sku and c.child_sku10 is NOT NULL;

