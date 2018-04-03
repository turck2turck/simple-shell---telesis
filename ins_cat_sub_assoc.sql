INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_barandbeverage' AND sub_category_name IN 
('cat2_barfurniture','cat2_barequipment','cat2_barware','cat2_icemachines','cat2_drinkdispensers');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_commercialkitchen' AND sub_category_name IN 
('cat2_cookingandwarming','cat2_kitchenware','cat2_knives','cat2_bakery','cat2_foodprep','cat2_cookchill',
'cat2_refrigeration','cat2_warewash','cat2_storageandtransportation');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_facilities' AND sub_category_name IN 
('cat2_lighting','cat2_paintandfinish','cat2_hardware','cat2_electrical','cat2_lockerroom');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_frontofhouse' AND sub_category_name IN 
('cat2_tabletop','cat2_housefurniture','cat2_merchandising','cat2_frontdesk','cat2_coffee','cat2_takeout','cat2_buffet');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_healthcare' AND sub_category_name IN 
('cat2_mealprep','cat2_mealdelivery','cat2_medicalcarts','cat2_medicalsupplies','cat2_furnishings');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_hospitality' AND sub_category_name IN 
('cat2_bellmanrooms','cat2_amenitysupplies','cat2_meetingrooms','cat2_laundry');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_janitorial' AND sub_category_name IN 
('cat2_chemicals','cat2_sanitation','cat2_safety','cat2_restroom','cat2_trashreceptacles','cat2_floorcare','cat2_cleaningtools');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_materialhandling' AND sub_category_name in
('cat2_carts','cat2_ladders','cat2_storage','cat2_dolliesandtrucks');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_plumbing' AND sub_category_name IN 
('cat2_sinks','cat2_faucets','cat2_otherfixtures','cat2_drainsanddisposers');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_services' AND sub_category_name IN 
('cat2_equipmentservices','cat2_designconstruct','cat2_facilityservices','cat2_apparelsupply','cat2_training');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_textilesandapparel' AND sub_category_name IN 
('cat2_apparel','cat2_textiles');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_promotionals' AND sub_category_name IN 
('cat2_giveaways');

INSERT INTO cat_sub_assoc (category_id, sub_category_id)
SELECT c.id, s.id from public.category c, public.sub_category s
WHERE category_name = 'cat1_officesupplies' AND sub_category_name IN 
('cat2_writingutensils'	,'cat2_paperandnotebooks','cat2_filingandstorage','cat2_mailing','cat2_officebasics',
'cat2_adhesives','cat2_electronics','cat2_batteries');
