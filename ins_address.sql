<<<<<<< HEAD
INSERT INTO public.address (address_hash,manufacturer_id,application_user_id,type,company_name,first_name,last_name,phone,address_1,address_2,city,state,postal,country,created_at,created_by)
SELECT md5(ROW(a.address_type,a.company_name,a.last_name,a.first_name,a.address_line_one,a.address_line_two,a.city,a.state,a.postal,a.country )::TEXT),m.id,1,'Corporate',a.company_name,'Customer','Service',NULL,a.address_line_one,a.address_line_two,a.city,a.state,a.postal,a.country,current_timestamp,'1'
FROM loading.manufacturer_address a, public.manufacturer m
WHERE a.mfr_abbr = m.mfr_abbr
ON CONFLICT(address_hash) DO UPDATE
SET type=EXCLUDED.type,company_name=EXCLUDED.company_name,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name,phone=EXCLUDED.phone,address_1=EXCLUDED.address_1,address_2=EXCLUDED.address_2,city=EXCLUDED.city,state=EXCLUDED.state,postal=EXCLUDED.postal,country=EXCLUDED.country,updated_at=current_timestamp,updated_by='1';
=======
INSERT INTO public.address (address_hash,application_user_id,manufacturer_id,type,company_name,first_name,last_name,address_1,address_2,city,state,postal,country, created_at,created_by)
SELECT address_hash,1,mfr_id,'Corporate',company_name,first_name,last_name,address_line_one,address_line_two,city,state,postal,country,current_timestamp,1
FROM loading.manufacturer_address 
ON CONFLICT (address_hash) DO UPDATE
SET company_name=EXCLUDED.company_name,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name,address_1=EXCLUDED.address_1,address_2=EXCLUDED.address_2,updated_at=current_timestamp,updated_by=1;
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
