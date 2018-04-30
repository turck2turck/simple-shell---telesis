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
     , split_part(a.epn_option_products, ',', 11) AS child_sku11
     , split_part(a.epn_option_products, ',', 12) AS child_sku12
     , split_part(a.epn_option_products, ',', 13) AS child_sku13
     , split_part(a.epn_option_products, ',', 14) AS child_sku14
     , split_part(a.epn_option_products, ',', 15) AS child_sku15
     , split_part(a.epn_option_products, ',', 16) AS child_sku16
     , split_part(a.epn_option_products, ',', 17) AS child_sku17
     , split_part(a.epn_option_products, ',', 18) AS child_sku18
     , split_part(a.epn_option_products, ',', 19) AS child_sku19
     , split_part(a.epn_option_products, ',', 20) AS child_sku20
     , split_part(a.epn_option_products, ',', 21) AS child_sku21
     , split_part(a.epn_option_products, ',', 22) AS child_sku22
     , split_part(a.epn_option_products, ',', 23) AS child_sku23
     , split_part(a.epn_option_products, ',', 24) AS child_sku24
     , split_part(a.epn_option_products, ',', 25) AS child_sku25
     , split_part(a.epn_option_products, ',', 26) AS child_sku26
     , split_part(a.epn_option_products, ',', 27) AS child_sku27
     , split_part(a.epn_option_products, ',', 28) AS child_sku28
     , split_part(a.epn_option_products, ',', 29) AS child_sku29
     , split_part(a.epn_option_products, ',', 30) AS child_sku30
     , split_part(a.epn_option_products, ',', 31) AS child_sku31
     , split_part(a.epn_option_products, ',', 32) AS child_sku32
     , split_part(a.epn_option_products, ',', 33) AS child_sku33
     , split_part(a.epn_option_products, ',', 34) AS child_sku34
     , split_part(a.epn_option_products, ',', 35) AS child_sku35
     , split_part(a.epn_option_products, ',', 36) AS child_sku36
     , split_part(a.epn_option_products, ',', 37) AS child_sku37
     , split_part(a.epn_option_products, ',', 38) AS child_sku38
     , split_part(a.epn_option_products, ',', 39) AS child_sku39
     , split_part(a.epn_option_products, ',', 40) AS child_sku40
     , split_part(a.epn_option_products, ',', 41) AS child_sku41
     , split_part(a.epn_option_products, ',', 42) AS child_sku42
     , split_part(a.epn_option_products, ',', 43) AS child_sku43
     , split_part(a.epn_option_products, ',', 44) AS child_sku44
     , split_part(a.epn_option_products, ',', 45) AS child_sku45
     , split_part(a.epn_option_products, ',', 46) AS child_sku46
     , split_part(a.epn_option_products, ',', 47) AS child_sku47
     , split_part(a.epn_option_products, ',', 48) AS child_sku48
     , split_part(a.epn_option_products, ',', 49) AS child_sku49
     , split_part(a.epn_option_products, ',', 50) AS child_sku50
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
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku11 = o.sku and m.child_sku11 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku12 = o.sku and m.child_sku12 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku13 = o.sku and m.child_sku13 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku14 = o.sku and m.child_sku14 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku15 = o.sku and m.child_sku15 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku16 = o.sku and m.child_sku16 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku17 = o.sku and m.child_sku17 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku18 = o.sku and m.child_sku18 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku19 = o.sku and m.child_sku19 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku20 = o.sku and m.child_sku20 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku21 = o.sku and m.child_sku21 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku22 = o.sku and m.child_sku22 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku23 = o.sku and m.child_sku23 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku24 = o.sku and m.child_sku24 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku25 = o.sku and m.child_sku25 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku26 = o.sku and m.child_sku26 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku27 = o.sku and m.child_sku27 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku28 = o.sku and m.child_sku28 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku29 = o.sku and m.child_sku29 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku30 = o.sku and m.child_sku30 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku31 = o.sku and m.child_sku31 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku32 = o.sku and m.child_sku32 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku33 = o.sku and m.child_sku33 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku34 = o.sku and m.child_sku34 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku35 = o.sku and m.child_sku35 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku36 = o.sku and m.child_sku36 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku37 = o.sku and m.child_sku37 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku38 = o.sku and m.child_sku38 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku39 = o.sku and m.child_sku39 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku40 = o.sku and m.child_sku40 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku41 = o.sku and m.child_sku41 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku42 = o.sku and m.child_sku42 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku43 = o.sku and m.child_sku43 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku44 = o.sku and m.child_sku44 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku45 = o.sku and m.child_sku45 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku46 = o.sku and m.child_sku46 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku47 = o.sku and m.child_sku47 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku48 = o.sku and m.child_sku48 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku49 = o.sku and m.child_sku49 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'P',o.id from public.product p, tmp_m m, public.option_product o
where m.product_hash = p.product_hash and m.child_sku50 = o.sku and m.child_sku50 is NOT NULL;



-- Look for options that have options. Grandkids.
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
     , split_part(a.epn_option_products, ',', 11) AS child_sku11
     , split_part(a.epn_option_products, ',', 12) AS child_sku12
     , split_part(a.epn_option_products, ',', 13) AS child_sku13
     , split_part(a.epn_option_products, ',', 14) AS child_sku14
     , split_part(a.epn_option_products, ',', 15) AS child_sku15
     , split_part(a.epn_option_products, ',', 16) AS child_sku16
     , split_part(a.epn_option_products, ',', 17) AS child_sku17
     , split_part(a.epn_option_products, ',', 18) AS child_sku18
     , split_part(a.epn_option_products, ',', 19) AS child_sku19
     , split_part(a.epn_option_products, ',', 20) AS child_sku20
     , split_part(a.epn_option_products, ',', 21) AS child_sku21
     , split_part(a.epn_option_products, ',', 22) AS child_sku22
     , split_part(a.epn_option_products, ',', 23) AS child_sku23
     , split_part(a.epn_option_products, ',', 24) AS child_sku24
     , split_part(a.epn_option_products, ',', 25) AS child_sku25
     , split_part(a.epn_option_products, ',', 26) AS child_sku26
     , split_part(a.epn_option_products, ',', 27) AS child_sku27
     , split_part(a.epn_option_products, ',', 28) AS child_sku28
     , split_part(a.epn_option_products, ',', 29) AS child_sku29
     , split_part(a.epn_option_products, ',', 30) AS child_sku30
     , split_part(a.epn_option_products, ',', 31) AS child_sku31
     , split_part(a.epn_option_products, ',', 32) AS child_sku32
     , split_part(a.epn_option_products, ',', 33) AS child_sku33
     , split_part(a.epn_option_products, ',', 34) AS child_sku34
     , split_part(a.epn_option_products, ',', 35) AS child_sku35
     , split_part(a.epn_option_products, ',', 36) AS child_sku36
     , split_part(a.epn_option_products, ',', 37) AS child_sku37
     , split_part(a.epn_option_products, ',', 38) AS child_sku38
     , split_part(a.epn_option_products, ',', 39) AS child_sku39
     , split_part(a.epn_option_products, ',', 40) AS child_sku40
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
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku11 = o.sku and c.child_sku11 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku12 = o.sku and c.child_sku12 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku13 = o.sku and c.child_sku13 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku14 = o.sku and c.child_sku14 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku15 = o.sku and c.child_sku15 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku16 = o.sku and c.child_sku16 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku17 = o.sku and c.child_sku17 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku18 = o.sku and c.child_sku18 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku19 = o.sku and c.child_sku19 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku20 = o.sku and c.child_sku20 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku21 = o.sku and c.child_sku21 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku22 = o.sku and c.child_sku22 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku23 = o.sku and c.child_sku23 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku24 = o.sku and c.child_sku24 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku25 = o.sku and c.child_sku25 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku26 = o.sku and c.child_sku26 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku27 = o.sku and c.child_sku27 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku28 = o.sku and c.child_sku28 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku29 = o.sku and c.child_sku29 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku30 = o.sku and c.child_sku30 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku31 = o.sku and c.child_sku31 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku32 = o.sku and c.child_sku32 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku33 = o.sku and c.child_sku33 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku34 = o.sku and c.child_sku34 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku35 = o.sku and c.child_sku35 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku36 = o.sku and c.child_sku36 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku37 = o.sku and c.child_sku37 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku38 = o.sku and c.child_sku38 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku39 = o.sku and c.child_sku39 is NOT NULL;
insert into public.product_option_assoc (parent_product_id,type_flag,child_product_id)
select p.id,'O',o.id from public.option_product p, tmp_c c, tmp_o o
where c.product_hash = p.product_hash and c.child_sku40 = o.sku and c.child_sku40 is NOT NULL;
