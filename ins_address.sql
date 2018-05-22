INSERT INTO public.address (manufacturer_id,application_user_id,type,company_name,first_name,last_name,phone,address_1,address_2,city,state,postal,country,created_at,created_by)
SELECT m.id,NULL,'corporate',a.company_name,'Customer','Service',NULL,a.address_line_one,a.address_line_two,a.city,a.state,a.postal,a.country,current_timestamp,'1'
FROM loading.manufacturer_address a, public.manufacturer m
WHERE a.mfr_abbr = m.mfr_abbr
--ON CONFLICT(address_hash) DO UPDATE
--SET type=EXCLUDED.type,company_name=EXCLUDED.company_name,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name,phone=EXCLUDED.phone,address_1=EXCLUDED.address_1,address_2=EXCLUDED.address_2,city=EXCLUDED.city,state=EXCLUDED.state,postal=EXCLUDED.postal,country=EXCLUDED.country,updated_at=current_timestamp,updated_by='1';
